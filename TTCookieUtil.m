//
//  TTCookieUtil.m
//  RYBaidu
//
//  Created by 小侠 on 2020/2/12.
//  Copyright © 2020 小侠. All rights reserved.
//

#import "TTCookieUtil.h"

@implementation TTCookieUtil


+(int) bytesToInt:(unsigned char*)src offset:(int)offset be:(BOOL)isBe
{
    return [self bytesToInt:&src offset:offset be:isBe autoStep:NO];
}


+(int) bytesToInt:(unsigned char**)_src offset:(int)offset be:(BOOL)isBe autoStep:(BOOL)isAutoStep
{
    int value;
    
    unsigned char* src = *_src;
    if(isBe)
        value = (int) ((src[offset+3] & 0xFF) | ((src[offset+2] & 0xFF)<<8) | ((src[offset+1] & 0xFF)<<16) | ((src[offset] & 0xFF)<<24));
    else
        value = (int) ((src[offset] & 0xFF) | ((src[offset+1] & 0xFF)<<8) | ((src[offset+2] & 0xFF)<<16) | ((src[offset+3] & 0xFF)<<24));
    
    if(isAutoStep)
        *_src += 4;
    
    return value;
}

@end
