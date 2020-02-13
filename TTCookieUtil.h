//
//  TTCookieUtil.h
//  RYBaidu
//
//  Created by 小侠 on 2020/2/12.
//  Copyright © 2020 小侠. All rights reserved.
//

#ifndef TTCookieUtil_h
#define TTCookieUtil_h

#import <Foundation/Foundation.h>

#define bytesReadInt(bytes, isBe) [TTCookieUtil bytesToInt:bytes offset:0 be:isBe]
#define bytesReadIntStep(bytes, isBe) [TTCookieUtil bytesToInt:bytes offset:0 be:isBe autoStep:YES]


@interface TTCookieUtil : NSObject

+(int) bytesToInt:(unsigned char*)src offset:(int)offset be:(BOOL)isBe;
+(int) bytesToInt:(unsigned char**)src offset:(int)offset be:(BOOL)isBe autoStep:(BOOL)isAutoStep;

@end

#endif /* TTCookieUtil_h */
