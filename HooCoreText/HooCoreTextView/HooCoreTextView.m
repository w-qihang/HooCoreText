//
//  HooCoreTextView.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCoreTextView.h"
#import "NSAttributedString+HooText.h"
#import "HooCTFrame.h"
#import <CoreText/CoreText.h>

#define kHooCharacterFont [UIFont systemFontOfSize:0.01]

@interface HooCoreTextView()
{
    LineVerticalAlignment lineVerticalAlignment_;
}
@end

@implementation HooCoreTextView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame lineVerticalAlignment:kLineVerticalAlignmentTop];
}
- (instancetype)initWithLineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment {
    return [self initWithFrame:CGRectZero lineVerticalAlignment:lineVerticalAlignment];
}
- (instancetype)initWithFrame:(CGRect)frame lineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment {
    if(self = [super initWithFrame:frame]) {
        self.muastring = [[NSMutableAttributedString alloc] init];
        lineVerticalAlignment_ = lineVerticalAlignment;
        [self addObserver:self forKeyPath:@"muastring" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsDisplay];
}

- (void)setMuastring:(NSMutableAttributedString *)muastring {
    _muastring = [muastring mutableCopy];
    _muastring.coreTextView = self;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    HooCTFrame *frame = [[HooCTFrame alloc]initWithAttributedString:self.muastring ContentRect:CGRectMake(_contentInsets.left, _contentInsets.top, self.bounds.size.width-_contentInsets.left-_contentInsets.right, self.bounds.size.height-_contentInsets.top-_contentInsets.bottom)];
    [frame drawInContext:UIGraphicsGetCurrentContext() InView:self];
}

- (void)appendNewLine {
    [self.muastring appendString:@"\n" font:kHooCharacterFont];
}
- (void)appendNewLineWithHeight:(float)height {
    double ascent=0,descent=0;
    [self.muastring lastLineAscent:&ascent descent:&descent];
    [self appendAttachmentWithContent:nil contentPosition:CGPointZero width:0 ascent:ascent descent:height+descent backgroundColor:nil];
    [self appendNewLine];
}
- (void)appendSpaceWithWidth:(float)width {
    [self appendSpaceWithWidth:width height:0];
}
- (void)appendSpaceWithWidth:(float)width height:(float)height {
    [self appendSpaceWithWidth:width height:height backgroundColor:nil];
}
- (void)appendSpaceWithWidth:(float)width height:(float)height backgroundColor:(UIColor *)backgroundColor {
    [self appendAttachmentWithContent:nil contentPosition:CGPointZero width:width height:height backgroundColor:backgroundColor];
}
- (void)appendImage:(UIImage *)image {
    [self appendImage:image position:CGPointZero];
}
- (void)appendImage:(UIImage *)image position:(CGPoint)position {
    [self appendAttachmentWithContent:image contentPosition:position width:image.size.width+position.x height:image.size.height+position.y backgroundColor:nil];
}
- (void)appendView:(UIView *)view {
    [self appendView:view position:CGPointZero];
}
- (void)appendView:(UIView *)view position:(CGPoint)position {
    [self appendAttachmentWithContent:view contentPosition:position width:view.bounds.size.width+position.x height:view.bounds.size.height+position.y backgroundColor:nil];
}
//- (void)appendImage:(UIImage *)image frame:(CGRect)frame {
//    [self appendSpaceWithWidth:frame.origin.x+frame.size.width height:frame.origin.y+frame.size.height backgroundColor:nil userInfo:@{kHooCTRunDelegateUserinfoContent:image,kHooCTRunDelegateUserinfoContentFrame:@(frame)}];
//}
//- (void)appendView:(UIView *)view {
//    [self appendSpaceWithWidth:view.frame.origin.x+view.frame.size.width height:view.frame.origin.y+view.frame.size.height backgroundColor:nil userInfo:@{kHooCTRunDelegateUserinfoContent:view,kHooCTRunDelegateUserinfoContentFrame:@(view.frame)}];
//}

- (void)appendAttachmentWithContent:(id)content contentPosition:(CGPoint)position width:(float)width height:(float)height backgroundColor:(UIColor *)backgroundColor {
    double ascent=0,descent=0;
    [self getAscent:&ascent descent:&descent byHeight:height];
    [self appendAttachmentWithContent:content contentPosition:position width:width ascent:ascent descent:descent backgroundColor:backgroundColor];
}

- (void)appendAttachmentWithContent:(id)content contentPosition:(CGPoint)position width:(float)width ascent:(float)ascent descent:(float)descent backgroundColor:(UIColor *)backgroundColor {
    [self.muastring appendAttributedString:[NSAttributedString attachmentStringWithContent:content contentPosition:position  width:width ascent:ascent descent:descent backgroundColor:backgroundColor]];
}

//根据LineVerticalAlignment计算ascent,descent
- (void)getAscent:(double *)ascent descent:(double *)descent byHeight:(double)height {
    double lastLineAscent=0,lastLineDescent=0;
    if(height > 0) {
        [self.muastring lastLineAscent:&lastLineAscent descent:&lastLineDescent];
        if(lastLineAscent < 9) {
            lastLineAscent = 9;
        }
        switch (lineVerticalAlignment_) {
            case kLineVerticalAlignmentTop:
                if(height>lastLineAscent) {
                    *ascent = lastLineAscent;
                    *descent = height-lastLineAscent;
                }
                else {
                    *ascent = height;
                    *descent = 0;
                }
                break;
            case kLineVerticalAlignmentCenter: //在一行上会居中显示
                if(height>lastLineAscent+lastLineDescent) {
                    *ascent = lastLineAscent+(height-lastLineAscent-lastLineDescent)/2;
                    *descent = lastLineDescent+(height-lastLineAscent-lastLineDescent)/2;
                }
                else {
                    *ascent = lastLineAscent-(lastLineAscent+lastLineDescent-height)/2;
                    *descent = lastLineDescent-(lastLineAscent+lastLineDescent-height)/2;
                }
                break;
            case kLineVerticalAlignmentBottom:
                if(height>lastLineDescent) {
                    *ascent = height-lastLineDescent;
                    *descent = lastLineDescent;
                    
                }
                else {
                    *ascent = 0;
                    *descent = height;
                }
                break;
            default:
                break;
        }
    }
    else {
        *ascent = 0;
        *descent = 0;
    }
}

- (void)hoo_resizeToFit {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_muastring);
    CGSize targetSize = CGSizeMake(self.bounds.size.width-_contentInsets.left-_contentInsets.right, CGFLOAT_MAX);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, (CFIndex)[_muastring length]), NULL, targetSize, NULL);
    CFRelease(framesetter);
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, ceilf(size.height)+_contentInsets.top+_contentInsets.bottom)];
    [self setNeedsDisplay];
}

- (void)dealloc {
    
}

@end
