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

@implementation NSAttributedString (HooText)

- (NSParagraphStyle *)hoo_paragraphStyle {
    return [self hoo_paragraphStyleAtIndex:0];
}
- (NSParagraphStyle *)hoo_paragraphStyleAtIndex:(NSUInteger)index {
    return [self hoo_paragraphStyleAtIndex:index effectiveRange:NULL];
}
- (NSParagraphStyle *)hoo_paragraphStyleAtIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range{
    id style = [self hoo_attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:range];
    if (style) {
        if (CFGetTypeID((__bridge CFTypeRef)(style)) == CTParagraphStyleGetTypeID()) {
            style = [NSParagraphStyle hoo_styleWithCTStyle:(__bridge CTParagraphStyleRef)style];
        }
    }
    return style;
}

- (id)hoo_attribute:(NSString *)attributeName atIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range{
    if (!attributeName) return nil;
    if (index > self.length || self.length == 0) return nil;
    if (self.length > 0 && index == self.length) index--;
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
