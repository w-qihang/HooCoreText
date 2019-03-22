//
//  HooCTFrame.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCTFrame.h"
#import "HooCTLine.h"
#import "HooCTRun.h"
#import "HooCTRunDelegate.h"
#import "HooTextAttachment.h"

@interface HooCTFrame() {
    CTFramesetterRef _framesetterRef;
    CTFrameRef _frameRef;
    NSAttributedString *_attributedString;
}

@end

@implementation HooCTFrame

- (void)drawInContext:(CGContextRef)context InView:(UIView *)superView {
    if(!self.lineArr) {
        return;
    }
    for(HooCTLine *line in self.lineArr) {
        NSLog(@"%@\n ........",line);
        
        if(!line.runArr) {
            return;
        }
        for(HooCTRun *run in line.runArr) {
            HooTextAttachment *attachment = run.textAttachment;
            HooCTRunDelegate *runDelegate = run.runDelegate;
            
            NSLog(@"%@",run);
            CGRect runRect = CGRectMake(line.position.x+run.position.x, line.position.y - run.position.y-run.ascent, run.width, run.ascent+run.descent+run.leading);
            NSLog(@"runRect = %@\n ........",NSStringFromCGRect(runRect));
            
            if(runDelegate && attachment) {
                CGRect contentRect = CGRectMake(_contentRect.origin.x+runRect.origin.x+attachment.contentInsets.left, _contentRect.origin.y+runRect.origin.y+attachment.contentInsets.top, runRect.size.width-attachment.contentInsets.left-attachment.contentInsets.right, runRect.size.height-attachment.contentInsets.top-attachment.contentInsets.bottom);
                if([attachment.content isKindOfClass:[UIImage class]]) {
                    CGContextDrawImage(context, contentRect, [(UIImage*)attachment.content CGImage]);
                }
                else if ([attachment.content isKindOfClass:[UIView class]]) {
                    [(UIView *)attachment.content setFrame:contentRect];
                    [superView addSubview:(UIView *)attachment.content];
                }
            }
        }
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
        _attributedString = [aStr copy];
        _framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedString);
        [self setContentRect:contentRect];
    }
    return self;
}
- (void)setContentRect:(CGRect)contentRect {
    _contentRect = contentRect;
    
    CGPathRef pathRef = CGPathCreateWithRect(_contentRect, &CGAffineTransformIdentity);
    if(_frameRef) CFRelease(_frameRef);
    _frameRef = CTFramesetterCreateFrame(_framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    CGRect cgPathBox = CGPathGetPathBoundingBox(pathRef);
    NSLog(@"pathRect = %@\n ",NSStringFromCGRect(cgPathBox));
    CGPathRelease(pathRef);
}
- (NSArray *)lineArr {
    if(!_frameRef)
        return nil;
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    if(!CFArrayGetCount(lines)) {
        return nil;
    }
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, CFArrayGetCount(lines)), lineOrigins);
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for(int i=0;i<CFArrayGetCount(lines);i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        HooCTLine *line = [[HooCTLine alloc] initWithLine:lineRef];
        //coretext坐标系转UIKit坐标系
        line.position = CGPointMake(lineOrigins[i].x, _contentRect.size.height+_contentRect.origin.y*2-lineOrigins[i].y);
        [mArr addObject:line];
    }
    return [mArr copy];
}

- (void)dealloc {
    if(_framesetterRef) CFRelease(_framesetterRef);
    if(_frameRef) CFRelease(_frameRef);
}

@end
