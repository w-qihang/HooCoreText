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

//换行
- (void)appendNewLine;
- (void)appendNewLineWithHeight:(float)height;
//追加空白区域
- (void)appendSpaceWithWidth:(float)width;
- (void)appendSpaceWithWidth:(float)width height:(float)height;
- (void)appendSpaceWithWidth:(float)width height:(float)height backgroundColor:(UIColor *)backgroundColor;
//追加图片
- (void)appendImage:(UIImage *)image;
- (void)appendImage:(UIImage *)image position:(CGPoint)position;
//追加视图
- (void)appendView:(UIView *)view;
- (void)appendView:(UIView *)view position:(CGPoint)position;

- (instancetype)initWithFrame:(CGRect)frame lineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment;
- (instancetype)initWithLineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment;

//重设coretextView高度,能加载全部coretext CTRun
- (void)hoo_resizeToFit;

@end
