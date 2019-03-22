//
//  NSParagraphStyle+HooText.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/12.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSParagraphStyle (HooText)

//ParagraphStyle的NS对象与CF对象互转
+ (NSParagraphStyle *)styleWithCTStyle:(CTParagraphStyleRef)CTStyle;
- (CTParagraphStyleRef)CTStyle CF_RETURNS_RETAINED;


//- (NSParagraphStyle *)hoo_styleWithlineSpacing
//paragraphSpacing
//alignment
//firstLineHeadIndent
//headIndent
//tailIndent
//lineBreakMode
//minimumLineHeight
//maximumLineHeight
//baseWritingDirection
//lineHeightMultiple
//paragraphSpacingBefore
//tabStops
//defaultTabInterval
@end
