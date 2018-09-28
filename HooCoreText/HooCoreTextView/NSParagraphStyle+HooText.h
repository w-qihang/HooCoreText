//
//  NSParagraphStyle+HooText.h
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/12.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSParagraphStyle (HooText)

+ (NSParagraphStyle *)hoo_styleWithCTStyle:(CTParagraphStyleRef)CTStyle;
- (CTParagraphStyleRef)hoo_CTStyle CF_RETURNS_RETAINED;


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
