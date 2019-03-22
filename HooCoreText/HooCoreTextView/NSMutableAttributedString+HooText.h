//
//  NSMutableAttributedString+HooCoreText.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HooCoreTextView;

@interface NSMutableAttributedString (HooText)

@property (nonatomic,weak) HooCoreTextView *coreTextView;

//text
- (void)appendString:(NSString *)string;
- (void)appendString:(NSString *)string font:(UIFont *)font;
- (void)appendString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;
- (void)appendString:(NSString *)string backgroundColor:(UIColor *)backgroundColor;
- (void)appendString:(NSString *)string font:(UIFont *)font color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;

//行间距
- (void)hoo_setLineSpacing:(float)lineSpacing range:(NSRange)range;
- (void)hoo_setLineSpacing:(float)lineSpacing;

//段间距
- (void)hoo_setParagraphSpacing:(float)paragraphSpacing range:(NSRange)range;
- (void)hoo_setParagraphSpacing:(float)paragraphSpacing;

//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
- (void)hoo_setAlignment:(float)alignment range:(NSRange)range;
- (void)hoo_setAlignment:(float)alignment;

//首行缩进
- (void)hoo_setFirstLineHeadIndent:(float)firstLineHeadIndent range:(NSRange)range;
- (void)hoo_setFirstLineHeadIndent:(float)firstLineHeadIndent;

//头部缩进，相当于左padding
- (void)hoo_setHeadIndent:(float)headIndent range:(NSRange)range;
- (void)hoo_setHeadIndent:(float)headIndent;

//相当于右padding
- (void)hoo_setTailIndent:(float)tailIndent range:(NSRange)range;
- (void)hoo_setTailIndent:(float)tailIndent;

//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
- (void)hoo_setLineBreakMode:(float)lineBreakMode range:(NSRange)range;
- (void)hoo_setLineBreakMode:(float)lineBreakMode;

//最低行高
- (void)hoo_setMinimumLineHeight:(float)minimumLineHeight range:(NSRange)range;
- (void)hoo_setMinimumLineHeight:(float)minimumLineHeight;

//最大行高
- (void)hoo_setMaximumLineHeight:(float)maximumLineHeight range:(NSRange)range;
- (void)hoo_setMaximumLineHeight:(float)maximumLineHeight;

//从左到右的书写方向
- (void)hoo_setBaseWritingDirection:(float)baseWritingDirection range:(NSRange)range;
- (void)hoo_setBaseWritingDirection:(float)baseWritingDirection;

//在受到最小和最大行高度约束之前，接收器的自然行高度乘以该因子（如果为正）
- (void)hoo_setLineHeightMultiple:(float)lineHeightMultiple range:(NSRange)range;
- (void)hoo_setLineHeightMultiple:(float)lineHeightMultiple;

//段首行空白空间
- (void)hoo_setParagraphSpacingBefore:(float)paragraphSpacingBefore range:(NSRange)range;
- (void)hoo_setParagraphSpacingBefore:(float)paragraphSpacingBefore;

//按位置排序的NSTextTab对象定义段落样式的制表位。 默认值是一个由12个左对齐制表符组成的数组，间隔为28磅。
- (void)hoo_setTabStops:(NSArray *)tabStops range:(NSRange)range;
- (void)hoo_setTabStops:(NSArray *)tabStops;

//默认tab间隔
- (void)hoo_setDefaultTabInterval:(float)defaultTabInterval range:(NSRange)range;
- (void)hoo_setDefaultTabInterval:(float)defaultTabInterval;


@end

















