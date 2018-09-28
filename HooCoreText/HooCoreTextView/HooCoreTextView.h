//
//  HooCoreTextView.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableAttributedString+HooText.h"

//line在垂直方向上的排列
typedef NS_ENUM(NSUInteger, LineVerticalAlignment) {
    kLineVerticalAlignmentTop,
    kLineVerticalAlignmentCenter,
    kLineVerticalAlignmentBottom,
};

@interface HooCoreTextView : UIView

@property (nonatomic) UIEdgeInsets contentInsets; //默认0,0,0,0

@property (nonatomic,strong) NSMutableAttributedString *muastring;

- (void)appendNewLine;
- (void)appendNewLineWithHeight:(float)height;
- (void)appendSpaceWithWidth:(float)width;
- (void)appendSpaceWithWidth:(float)width height:(float)height;
- (void)appendSpaceWithWidth:(float)width height:(float)height backgroundColor:(UIColor *)backgroundColor;
- (void)appendImage:(UIImage *)image;
- (void)appendImage:(UIImage *)image frame:(CGRect)frame;
- (void)appendView:(UIView *)view;

- (instancetype)initWithFrame:(CGRect)frame lineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment;
- (instancetype)initWithLineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment;

@end
