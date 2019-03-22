//
//  HooCTLine.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface HooCTLine : NSObject

@property (nonatomic) CGPoint position;

@property (nonatomic,readonly) CGFloat ascent;
@property (nonatomic,readonly) CGFloat descent;
@property (nonatomic,readonly) CGFloat leading;
@property(nonatomic,strong,readonly) NSArray *runArr;

- (instancetype)initWithLine:(CTLineRef)lineRef;
@end
