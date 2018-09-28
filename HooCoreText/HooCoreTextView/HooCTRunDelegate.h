//
//  HooCoreTextRunDelegate.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

extern NSString *const kHooCTRunDelegateUserinfoContent;
extern NSString *const kHooCTRunDelegateUserinfoContentFrame;

@interface HooCTRunDelegate : NSObject

@property (nonatomic) CGFloat ascent;
@property (nonatomic) CGFloat descent;
@property (nonatomic) CGFloat width;
@property (nonatomic, strong) NSDictionary *userInfo;

- (CTRunDelegateRef)CTRunDelegateRef CF_RETURNS_RETAINED;
@end
