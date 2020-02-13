//
//  TTCookieStorages.m
//  RYBaidu
//
//  Created by 小侠 on 2020/2/12.
//  Copyright © 2020 小侠. All rights reserved.

#import "TTCookieStorages.h"
#import "TTCookieItem.h"
#import "TTCookieUtil.h"


#define TTCookieStoragesError(tMsg, tCode) [NSError errorWithDomain:[NSString stringWithFormat:@"【Error】%s %@", __func__, tMsg] code:tCode userInfo:nil]
#define CheckCookieStoragesError(tMsg, tCode) if(complete) \
                            complete(TTCookieStoragesError(tMsg, tCode));


@implementation TTCookieStorages


+(TTCookieStorages*) Shared
{
    static dispatch_once_t onceToken;
    static TTCookieStorages* instance;
    dispatch_once(&onceToken, ^{
        instance = [[TTCookieStorages alloc] init];
    });
    
    return instance;
}


-(id) init
{
    self = [super init];
    if(self){
    }
    return self;
}



/**
 * 解析当前沙盒下Cookies.binarycookies文件
*/
-(NSArray<TTCookieItem*>*) tt_decode
{
    return [self tt_decodeWithPath:[self tt_defaultPath] complete:nil];
}



/**
 * 解析Cookies.binarycookies文件
 */
-(NSArray<TTCookieItem*>*) tt_decodeWithPath:(NSString*)path complete:(void (^)(NSError* error))complete
{
    
    do{
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path] == NO){
            CheckCookieStoragesError(@"File not found!", 1);
            break;
        }
        
        NSData* data = [NSData dataWithContentsOfFile:path];
        if(data == nil){
            CheckCookieStoragesError(@"File can`t read!", 1);
            break;
        }
        
        return [self tt_decodeWithData:data complete:complete];
        
    } while(0);
    
    return nil;
}


/**
 * 解析Cookies.binarycookies数据
 *
 * @return 返回解析后的cookie数据.
*/
-(NSArray<TTCookieItem*>*) tt_decodeWithData:(NSData*)data complete:(void (^)(NSError* error))complete
{
    NSMutableArray<TTCookieItem*>* root = [NSMutableArray array];
    
    do{
        
        NSLog(@"%@", data);
        
        if(data == nil){
            CheckCookieStoragesError(@"data is nil!", 2);
            break;
        }
        
        
        // data header
        unsigned char* bytes = (unsigned char*)[data bytes];
        if(memcmp(bytes, "cook", 4) != 0){ //0x636f6f6b
            CheckCookieStoragesError(@"data header data is not 0x636f6f6b", 2);
            break;
        }
        bytes = bytes+4;
        
        // pageSize
        int pageCount = bytesReadIntStep(&bytes, YES);
        
        
        // pagesLenth
        unsigned int pageSizes[pageCount];
        for (int i=0; i<pageCount; i++) {
            pageSizes[i] = bytesReadIntStep(&bytes, YES);
        }
        
        
        // loop pages
        int beginIndex = 0;
        for (int i=0; i<pageCount; i++) {
            unsigned char* begin = bytes + beginIndex;
            beginIndex += pageSizes[i];
            NSMutableArray<TTCookieItem*>* result = [self decodePageData:begin complete:complete];
            [root addObjectsFromArray:result];
        }
        
    } while(0);
    
    
    if(complete)
        complete(nil);
    
    return root;
}


/**
 默认解析路径
 */
-(NSString*) tt_defaultPath
{
    return [NSHomeDirectory() stringByAppendingString:@"/Library/Cookies/Cookies.binarycookies"];
}




#pragma mark ----- private ----

/**
 * 解析当前页
 */
-(NSMutableArray<TTCookieItem*>*) decodePageData:(unsigned char*)bytes complete:(void (^)(NSError* error))complete
{
    
    NSMutableArray<TTCookieItem*>* root = [NSMutableArray array];
    
    do{
        unsigned char* src = bytes;
        
        // page header
        int pageHeader = bytesReadIntStep(&bytes, YES);
        if(pageHeader != 0x00000100){
            CheckCookieStoragesError(@"page header is error, not 0x00000100!", 3);
            break;
        }
        
        // number of cookies in the page
        unsigned int cookieCount = bytesReadIntStep(&bytes, NO);
        for (int i=0; i<cookieCount; i++) {
            int offset = bytesReadIntStep(&bytes, NO);
            TTCookieItem* item =[[TTCookieItem alloc] initWithBytes:src+offset];
            [root addObject:item];
        }
        
    } while(0);
    
    return root;
}




@end

