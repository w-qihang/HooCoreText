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
#import "HooCTRunDelegate.h"

#define kHooCharacterFont [UIFont systemFontOfSize:0.01]

@interface HooCoreTextView()
{
    LineVerticalAlignment lineVerticalAlignment_;
}
@end

@implementation HooCoreTextView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame lineVerticalAlignment:kLineVerticalAlignmentTop];
}
- (instancetype)initWithLineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment {
    return [self initWithFrame:CGRectZero lineVerticalAlignment:lineVerticalAlignment];
}
- (instancetype)initWithFrame:(CGRect)frame lineVerticalAlignment:(LineVerticalAlignment)lineVerticalAlignment {
    if(self = [super initWithFrame:frame]) {
        lineVerticalAlignment_ = lineVerticalAlignment;
    }
    return self;
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString {
    _muastring = attributedString;
    [self setNeedsDisplay];
}
- (NSMutableAttributedString *)muastring {
    if(!_muastring) {
        _muastring = [[NSMutableAttributedString alloc] init];
    }
    return _muastring;
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    HooCTFrame *frame = [[HooCTFrame alloc]initWithAttributedString:self.muastring ContentRect:CGRectMake(_contentInsets.top, _contentInsets.left, self.bounds.size.width-_contentInsets.left-_contentInsets.right, self.bounds.size.height-_contentInsets.top-_contentInsets.bottom)];
//    for(HooCTLine *line in frame.lineArr) {
//        for (HooCTRun *run in line.ru  nArr) {
//
//        }
//    }
    
    [frame drawInContext:UIGraphicsGetCurrentContext() appendViewBlock:^(UIView *subview) {
        [self addSubview:subview];
    }];
}

- (void)appendNewLine {
    [self.muastring appendString:@"\n" font:kHooCharacterFont];
}
- (void)appendNewLineWithHeight:(float)height {
    double ascent=0,descent=0;
    [self.muastring lastLineAscent:&ascent descent:&descent];
    [self appendSpaceWithWidth:0 ascent:ascent descent:height+descent backgroundColor:nil userInfo:nil];
    [self appendNewLine];
}
- (void)appendSpaceWithWidth:(float)width {
    [self appendSpaceWithWidth:width height:0];
}
- (void)appendSpaceWithWidth:(float)width height:(float)height {
    [self appendSpaceWithWidth:width height:height backgroundColor:nil];
}
- (void)appendSpaceWithWidth:(float)width height:(float)height backgroundColor:(UIColor *)backgroundColor {
    [self appendSpaceWithWidth:width height:height backgroundColor:backgroundColor userInfo:nil];
}
- (void)appendImage:(UIImage *)image {
    [self appendImage:image frame:CGRectMake(0, 0, image.size.width, image.size.height)];
}
- (void)appendImage:(UIImage *)image frame:(CGRect)frame {
    [self appendSpaceWithWidth:frame.origin.x+frame.size.width height:frame.origin.y+frame.size.height backgroundColor:nil userInfo:@{kHooCTRunDelegateUserinfoContent:image,kHooCTRunDelegateUserinfoContentFrame:@(frame)}];
}
- (void)appendView:(UIView *)view {
    [self appendSpaceWithWidth:view.frame.origin.x+view.frame.size.width height:view.frame.origin.y+view.frame.size.height backgroundColor:nil userInfo:@{kHooCTRunDelegateUserinfoContent:view,kHooCTRunDelegateUserinfoContentFrame:@(view.frame)}];
}

- (void)appendSpaceWithWidth:(float)width height:(float)height backgroundColor:(UIColor *)backgroundColor userInfo:(NSDictionary *)userInfo{
    double ascent=0,descent=0;
    if(height>0) {
        [self.muastring lastLineAscent:&ascent descent:&descent];
        switch (lineVerticalAlignment_) {
            case kLineVerticalAlignmentTop:
                if(height>ascent) {
                    [self appendSpaceWithWidth:width ascent:ascent descent:height-ascent backgroundColor:backgroundColor userInfo:userInfo];
                }
                else {
                    [self appendSpaceWithWidth:width ascent:height descent:0 backgroundColor:backgroundColor userInfo:userInfo];
                }
                break;
            case kLineVerticalAlignmentCenter:
                if(height>ascent+descent) {
                    [self appendSpaceWithWidth:width ascent:ascent+(height-ascent-descent)/2 descent:descent+(height-ascent-descent)/2 backgroundColor:backgroundColor userInfo:userInfo];
                }
                else if(height>ascent) {
                    [self appendSpaceWithWidth:width ascent:ascent descent:height-ascent backgroundColor:backgroundColor userInfo:userInfo];
                }
                else {
                    [self appendSpaceWithWidth:width ascent:height descent:0 backgroundColor:backgroundColor userInfo:userInfo];
                }
                break;
            case kLineVerticalAlignmentBottom:
                if(height>descent) {
                    [self appendSpaceWithWidth:width ascent:height-descent descent:descent backgroundColor:backgroundColor userInfo:userInfo];
                }
                else {
                    [self appendSpaceWithWidth:width ascent:0 descent:height backgroundColor:backgroundColor userInfo:userInfo];
                }
                break;
            default:
                break;
        }
        
    }
    else
        [self appendSpaceWithWidth:width ascent:0 descent:0 backgroundColor:backgroundColor userInfo:userInfo];
}
- (void)appendSpaceWithWidth:(float)width ascent:(float)ascent descent:(float)descent  backgroundColor:(UIColor *)backgroundColor userInfo:(NSDictionary *)userInfo{
    HooCTRunDelegate *delegate = [[HooCTRunDelegate alloc]init];
    delegate.width = width;
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.userInfo = userInfo;
    CTRunDelegateRef ref = [delegate CTRunDelegateRef];
    
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    
    NSMutableAttributedString *maString = [[NSMutableAttributedString alloc]initWithString:content];
    [maString addAttribute:(id)kCTRunDelegateAttributeName value:(__bridge_transfer id)ref range:NSMakeRange(0,maString.length)];
    if(backgroundColor)
        [maString addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:NSMakeRange(0, maString.length)];
    [self.muastring appendAttributedString:maString];
}

- (void)dealloc {
    
}

@end
