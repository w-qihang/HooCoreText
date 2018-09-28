////
//  HooCoreTextRunDelegate.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCTRunDelegate.h"

NSString *const kHooCTRunDelegateUserinfoContent = @"kHooCTRunDelegateUserinfoContent";
NSString *const kHooCTRunDelegateUserinfoContentFrame = @"kHooCTRunDelegateUserinfoContentFrame";

static void DeallocateCallback(void *ref) {
    HooCTRunDelegate *self = (__bridge_transfer HooCTRunDelegate *)ref;
    self = nil;
}
static CGFloat GetAscentCallback(void *ref) {
    HooCTRunDelegate *self = (__bridge HooCTRunDelegate *)ref;
    return self.ascent;
}
static CGFloat GetDescentCallback(void *ref) {
    HooCTRunDelegate *self = (__bridge HooCTRunDelegate *)ref;
    return self.descent;
}
static CGFloat GetWidthCallback(void *ref) {
    HooCTRunDelegate *self = (__bridge HooCTRunDelegate *)ref;
    return self.width;
}

@implementation HooCTRunDelegate

- (CTRunDelegateRef)CTRunDelegateRef CF_RETURNS_RETAINED {
    CTRunDelegateCallbacks callbacks;
    callbacks.version = kCTRunDelegateCurrentVersion;
    callbacks.dealloc = DeallocateCallback;
    callbacks.getAscent = GetAscentCallback;
    callbacks.getDescent = GetDescentCallback;
    callbacks.getWidth = GetWidthCallback;
    return CTRunDelegateCreate(&callbacks,(__bridge_retained void *)self);
}
//- (id)copyWithZone:(NSZone *)zone {
//    typeof(self) one = [self.class new];
//    one.ascent = self.ascent;
//    one.descent = self.descent;
//    one.width = self.width;
//    //one.userInfo = self.userInfo;
//    return one;
//}
@end
