//
//  HooCTFrame.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCTFrame.h"
#import "HooCTLine.h"
#import "HooCTRunDelegate.h"
#import <UIKit/UIKit.h>

@interface HooCTFrame() {
    CTFramesetterRef _framesetterRef;
    CTFrameRef _frameRef;
}

@end

@implementation HooCTFrame

- (void)drawInContext:(CGContextRef)context appendViewBlock:(void (^)(UIView *))block{
    if(!_frameRef)
        return;
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, 0), lineOrigins);
    
    CGFloat heightAddup = 0;
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        
        CGFloat runHeight = lineAscent + lineDescent + lineLeading;
        CGFloat startX = 0;
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            
            CGFloat runAscent;
            CGFloat runDescent;
            CGFloat runLeading;
            CGFloat runWidth = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, &runLeading);
            
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CTRunDelegateRef runDelegateRef = (__bridge CTRunDelegateRef)[attributes objectForKey:@"CTRunDelegate"];
            HooCTRunDelegate *runDelegate = CTRunDelegateGetRefCon(runDelegateRef);
            
            CGRect runRect = CGRectMake(startX, heightAddup, runWidth, runAscent + runDescent);
            if(runDelegate && runDelegate.userInfo) {
                id content = [runDelegate.userInfo objectForKey:kHooCTRunDelegateUserinfoContent];
                CGRect rect = [[runDelegate.userInfo objectForKey:kHooCTRunDelegateUserinfoContentFrame] CGRectValue];
                CGRect contentRect = CGRectMake(runRect.origin.x+rect.origin.x, runRect.origin.y+rect.origin.y, rect.size.width, rect.size.height);
                if([content isKindOfClass:[UIImage class]]) {
                    CGContextDrawImage(context, contentRect, [(UIImage*)content CGImage]);
                }
                else if ([content isKindOfClass:[UIView class]]) {
                    [(UIView *)content setFrame:contentRect];
                    //[[(UIView *)content layer] drawInContext:context];
                    if(block)
                        block((UIView *)content);
                }
            }
            startX += runWidth;
        }
        heightAddup += runHeight;
    }

    //调整坐标
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    CGContextTranslateCTM(context, 0, (_contentRect.size.height+_contentRect.origin.y*2));
    CGContextScaleCTM(context, 1, -1);
    if(_frameRef)
        CTFrameDraw(_frameRef, context);
}

- (instancetype)initWithAttributedString:(NSAttributedString *)aStr {
    return [self initWithAttributedString:aStr ContentRect:CGRectZero];
}

- (instancetype)initWithAttributedString:(NSAttributedString *)aStr ContentRect:(CGRect)contentRect{
    if(self = [super init]) {
        _framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aStr);
        [self setContentRect:contentRect];
    }
    return self;
}
- (void)setContentRect:(CGRect)contentRect {
    _contentRect = contentRect;
    CGPathRef pathRef = CGPathCreateWithRect(_contentRect, &CGAffineTransformIdentity);
    if(_frameRef) CFRelease(_frameRef);
    _frameRef = CTFramesetterCreateFrame(_framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    CGPathRelease(pathRef);
}
- (NSArray *)lineArr {
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    NSArray *arr = (__bridge NSArray *)CTFrameGetLines(_frameRef);
    for (int i=0;i<arr.count;i++) {
        CTLineRef lineRef = (__bridge CTLineRef)arr[i];
        HooCTLine *line = [[HooCTLine alloc] initWithLine:lineRef];
        [mArr addObject:line];
    }
    return [mArr copy];
}

- (void)dealloc {
    if(_framesetterRef) CFRelease(_framesetterRef);
    if(_frameRef) CFRelease(_frameRef);    
}

@end
