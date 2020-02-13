//
//  TTCookieStorages.h
//  RYBaidu
//
//  Created by 小侠 on 2020/2/12.
//  Copyright © 2020 小侠. All rights reserved.
//

#ifndef TTCookieStorages_h
#define TTCookieStorages_h

#import <Foundation/Foundation.h>


@class TTCookieItem;

@interface TTCookieStorages : NSObject
{
}



+(TTCookieStorages*) Shared;


/**
* 解析当前沙盒下Cookies.binarycookies文件
*
* @return 返回解析后的cookie数据.
*/
-(NSArray<TTCookieItem*>*) tt_decode;



/**
* 解析Cookies.binarycookies文件
*
* @param path 绝对路径
*
* @param complete 完成时回调， error==nil时成功。
*
* @return 返回解析后的cookie数据.
*/
-(NSArray<TTCookieItem*>*) tt_decodeWithPath:(NSString*)path complete:(void (^)(NSError* error))complete;


/**
* 解析Cookies.binarycookies文件
*
* @param data Cookies.binarycookies源数据
*
* @param complete 完成时回调， error==nil时成功。
*
* @return 返回解析后的cookie数据.
*/
-(NSArray<TTCookieItem*>*) tt_decodeWithData:(NSData*)data complete:(void (^)(NSError* error))complete;



/**
 默认解析路径
 */
-(NSString*) tt_defaultPath;

@end



#endif /* TTCookieStorages_h */
