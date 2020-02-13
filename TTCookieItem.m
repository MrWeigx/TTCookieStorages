//
//  TTCookieItem.m
//  RYBaidu
//
//  Created by 小侠 on 2020/2/12.
//  Copyright © 2020 小侠. All rights reserved.
//

#import "TTCookieItem.h"
#import "TTCookieUtil.h"

@implementation TTCookieItem

-(TTCookieItem*) initWithBytes:(unsigned char*)bytes
{
    self = [super init];
    if(self){
        [self decodeWithByte:bytes];
    }
    return self;
}


-(void) decodeWithByte:(unsigned char*)bytes
{
    unsigned char* src = bytes;
    
    //size of the cookie
    unsigned int cookieSize = bytesReadIntStep(&bytes, NO);
    // version 0 or 1
    unsigned int version = bytesReadIntStep(&bytes, NO);
    // Cookie flags
    unsigned int flags = bytesReadIntStep(&bytes, NO);
    // Has port 0 or 1
    unsigned int hasPort = bytesReadIntStep(&bytes, NO);
    
    int url_offset      = bytesReadIntStep(&bytes, NO);
    int name_offset     = bytesReadIntStep(&bytes, NO);
    int path_offset     = bytesReadIntStep(&bytes, NO);
    int value_offset    = bytesReadIntStep(&bytes, NO);
    
    _domain = [[NSString alloc] initWithBytes:src+url_offset length:name_offset-url_offset encoding:4];
    _name   = [[NSString alloc] initWithBytes:src+name_offset length:path_offset-name_offset encoding:4];
    _path   = [[NSString alloc] initWithBytes:src+path_offset length:value_offset-path_offset encoding:4];
    _value  = [[NSString alloc] initWithCString:src+value_offset encoding:4];
}


-(NSString*) description
{
    return [NSString stringWithFormat:@"%@=%@ | domain=%@ | path=%@", _name, _value, _domain, _path];
}

@end
