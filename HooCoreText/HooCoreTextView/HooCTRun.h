//
//  HooCTRun.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@class HooCTRunDelegate;
@class HooTextAttachment;

@interface HooCTRun : NSObject

@property (nonatomic,readonly) CGPoint position;  
@property (nonatomic,readonly) CGFloat ascent;  //上行高度
@property (nonatomic,readonly) CGFloat descent;  //下行高度
@property (nonatomic,readonly) CGFloat leading;
@property (nonatomic,readonly) CGFloat width;
@property (nonatomic,readonly) HooCTRunDelegate *runDelegate;
@property (nonatomic,readonly) HooTextAttachment *textAttachment;

- (instancetype)initWithRun:(CTRunRef)runRef;
@end
