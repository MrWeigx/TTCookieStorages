//
//  TTCookieItem.h
//  RYBaidu
//
//  Created by 小侠 on 2020/2/12.
//  Copyright © 2020 小侠. All rights reserved.
//

#ifndef TTCookieItem_h
#define TTCookieItem_h

#import <Foundation/Foundation.h>

@interface TTCookieItem : NSObject

@property (strong, nonatomic) NSString* domain;
@property (strong, nonatomic) NSString* path;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* value;


-(TTCookieItem*) initWithBytes:(unsigned char*)bytes;

@end

#endif /* TTCookieItem_h */
