//
//  HooCTFrame.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HooCTFrame : NSObject

@property(nonatomic) CGRect contentRect;
@property(nonatomic,strong,readonly) NSArray *lineArr;

- (instancetype)initWithAttributedString:(NSAttributedString *)aStr;
- (instancetype)initWithAttributedString:(NSAttributedString *)aStr ContentRect:(CGRect)contentRect;

- (void)drawInContext:(CGContextRef)context InView:(UIView *)superView;

@end
