//
//  NSAttributedString+HooText.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/12.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "NSAttributedString+HooText.h"
#import "NSParagraphStyle+HooText.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
#import "HooCTRunDelegate.h"
#import "HooTextAttachment.h"

@implementation NSAttributedString (HooText)

+ (NSAttributedString *)attachmentStringWithContent:(id)content contentPosition:(CGPoint)position width:(float)width ascent:(float)ascent descent:(float)descent backgroundColor:(UIColor *)backgroundColor {
    unichar objectReplacementChar = 0xFFFC;
    NSString *str = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *maString = [[NSMutableAttributedString alloc]initWithString:str];
    
    HooCTRunDelegate *delegate = [[HooCTRunDelegate alloc]init];
    delegate.width = width;
    delegate.ascent = ascent;
    delegate.descent = descent;
    //delegate.userInfo = userInfo;
    CTRunDelegateRef ref = [delegate CTRunDelegateRef];
    [maString addAttribute:(id)kCTRunDelegateAttributeName value:(__bridge_transfer id)ref range:NSMakeRange(0,maString.length)];
    
    if(content) {
        HooTextAttachment *textAttachment = [[HooTextAttachment alloc]initWithContent:content];
        textAttachment.contentInsets = UIEdgeInsetsMake(position.y, position.x, 0, 0);
        [maString addAttribute:kHooTextAttachmentAttributeName value:textAttachment range:NSMakeRange(0,maString.length)];
    }
    if(backgroundColor) {
        [maString addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:NSMakeRange(0,maString.length)];
    }
    
    return [maString copy];
}

- (NSParagraphStyle *)paragraphStyle {
    return [self paragraphStyleAtIndex:0];
}
- (NSParagraphStyle *)paragraphStyleAtIndex:(NSUInteger)index {
    return [self paragraphStyleAtIndex:index effectiveRange:NULL];
}
- (NSParagraphStyle *)paragraphStyleAtIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range{
    id style = [self attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:range];
    if (style) {
        if (CFGetTypeID((__bridge CFTypeRef)(style)) == CTParagraphStyleGetTypeID()) {
            style = [NSParagraphStyle styleWithCTStyle:(__bridge CTParagraphStyleRef)style];
        }
    }
    return style;
}

- (id)attribute:(NSString *)attributeName atIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range{
    if (!attributeName) return nil;
    if (index > self.length || self.length == 0) return nil;
    //if (self.length > 0 && index == self.length) index--;
    return [self attribute:attributeName atIndex:index effectiveRange:range];
}

- (void)lastLineAscent:(double *)ascent descent:(double *)descent {
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGPathRef pathRef = CGPathCreateWithRect(CGRectMake(0, 0, MAXFLOAT, MAXFLOAT), &CGAffineTransformIdentity);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(framesetterRef);
    CGPathRelease(pathRef);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    if(CFArrayGetCount(lines)>0) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, CFArrayGetCount(lines)-1);
        CTLineGetTypographicBounds(line, ascent, descent, NULL);
    }
    CFRelease(frameRef);
}

//- (void)setLineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment {
//    ;
//    objc_setAssociatedObject(self, @selector(lineVerticalAlignment), @(lineVerticalAlignment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (LineVerticalAlignment)lineVerticalAlignment {
//    NSNumber *num = objc_getAssociatedObject(self, @selector(lineVerticalAlignment));
//    if(!num) {
//        num = @(kLineVerticalAlignmentCenter);
//        objc_setAssociatedObject(self, @selector(lineVerticalAlignment), num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return [num unsignedLongValue];
//}
@end
