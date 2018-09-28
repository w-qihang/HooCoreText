//
//  NSMutableAttributedString+HooCoreText.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "NSMutableAttributedString+HooText.h"

@implementation NSMutableAttributedString (HooText)

- (void)appendString:(NSString *)string {
    [self appendString:string font:nil color:nil backgroundColor:nil];
}
- (void)appendString:(NSString *)string font:(UIFont *)font {
    [self appendString:string font:font color:nil];
}
- (void)appendString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    [self appendString:string font:font color:color backgroundColor:nil];
}
- (void)appendString:(NSString *)string backgroundColor:(UIColor *)backgroundColor {
    [self appendString:string font:nil color:nil backgroundColor:backgroundColor];
}
- (void)appendString:(NSString *)string font:(UIFont *)font color:(UIColor *)color  backgroundColor:(UIColor *)backgroundColor {
    NSMutableAttributedString *astring = [[NSMutableAttributedString alloc]initWithString:string];
    if(font)
        [astring addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, astring.length)];
    if(color)
        [astring addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, astring.length)];
    if(backgroundColor)
        [astring addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:NSMakeRange(0, astring.length)];
    [self appendAttributedString:astring];
}

#define HooSetParagraphAttributeAtRange(_attr_) \
if(range.location+range.length>self.length) {NSLog(@"out of range"); return;} \
[self enumerateAttribute:NSParagraphStyleAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) { \
NSParagraphStyle *style = (NSParagraphStyle *)value; \
NSMutableParagraphStyle *muStyle = nil; \
if(style) { \
    [self removeAttribute:NSParagraphStyleAttributeName range:range]; \
    muStyle = [style mutableCopy]; \
} else { \
    muStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy]; \
} \
muStyle._attr_ = _attr_; \
[self addAttribute:NSParagraphStyleAttributeName value:muStyle range:range]; \
}];


- (void)hoo_setLineSpacing:(float)lineSpacing {
    [self hoo_setLineSpacing:lineSpacing range:NSMakeRange(0, self.length)];
}
- (void)hoo_setLineSpacing:(float)lineSpacing range:(NSRange)range {
    //HooSetParagraphAttributeAtRange(lineSpacing);
    
    //CFTypeRef ref = (__bridge CFTypeRef)self;
    //NSLog(@"retaincout = %ld",CFGetRetainCount(ref));
    //NSLog(@"sub = %@",[self attributedSubstringFromRange:range]);
    if(range.location+range.length>self.length) {NSLog(@"out of range"); return;}
    [self enumerateAttribute:NSParagraphStyleAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        NSParagraphStyle *style = (NSParagraphStyle *)value;
        NSMutableParagraphStyle *muStyle = nil;
        if(style) {
            [self removeAttribute:NSParagraphStyleAttributeName range:range];
            muStyle = [style mutableCopy];
        }
        else {
            muStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        }
        muStyle.lineSpacing = lineSpacing;
        [self addAttribute:NSParagraphStyleAttributeName value:muStyle range:range];
    }];

}

- (void)hoo_setParagraphSpacing:(float)paragraphSpacing {
    [self hoo_setParagraphSpacing:paragraphSpacing range:NSMakeRange(0, self.length)];
}
- (void)hoo_setParagraphSpacing:(float)paragraphSpacing range:(NSRange)range {
    HooSetParagraphAttributeAtRange(paragraphSpacing);
}

- (void)hoo_setAlignment:(float)alignment {
    [self hoo_setAlignment:alignment range:NSMakeRange(0, self.length)];
}
- (void)hoo_setAlignment:(float)alignment range:(NSRange)range {
    HooSetParagraphAttributeAtRange(alignment);
}

- (void)hoo_setFirstLineHeadIndent:(float)firstLineHeadIndent {
    [self hoo_setFirstLineHeadIndent:firstLineHeadIndent range:NSMakeRange(0, self.length)];
}
- (void)hoo_setFirstLineHeadIndent:(float)firstLineHeadIndent range:(NSRange)range {
    HooSetParagraphAttributeAtRange(firstLineHeadIndent);
}

- (void)hoo_setHeadIndent:(float)headIndent {
    [self hoo_setHeadIndent:headIndent range:NSMakeRange(0, self.length)];
}
- (void)hoo_setHeadIndent:(float)headIndent range:(NSRange)range {
    HooSetParagraphAttributeAtRange(headIndent);
}

- (void)hoo_setTailIndent:(float)tailIndent {
    [self hoo_setTailIndent:tailIndent range:NSMakeRange(0, self.length)];
}
- (void)hoo_setTailIndent:(float)tailIndent range:(NSRange)range {
    HooSetParagraphAttributeAtRange(tailIndent);
}

- (void)hoo_setLineBreakMode:(float)lineBreakMode {
    [self hoo_setLineBreakMode:lineBreakMode range:NSMakeRange(0, self.length)];
}
- (void)hoo_setLineBreakMode:(float)lineBreakMode range:(NSRange)range {
    HooSetParagraphAttributeAtRange(lineBreakMode);
}

- (void)hoo_setMinimumLineHeight:(float)minimumLineHeight {
    [self hoo_setMinimumLineHeight:minimumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)hoo_setMinimumLineHeight:(float)minimumLineHeight range:(NSRange)range {
    HooSetParagraphAttributeAtRange(minimumLineHeight);
}

- (void)hoo_setMaximumLineHeight:(float)maximumLineHeight {
    [self hoo_setMaximumLineHeight:maximumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)hoo_setMaximumLineHeight:(float)maximumLineHeight range:(NSRange)range {
    HooSetParagraphAttributeAtRange(maximumLineHeight);
}

- (void)hoo_setBaseWritingDirection:(float)baseWritingDirection {
    [self hoo_setBaseWritingDirection:baseWritingDirection range:NSMakeRange(0, self.length)];
}
- (void)hoo_setBaseWritingDirection:(float)baseWritingDirection range:(NSRange)range {
    HooSetParagraphAttributeAtRange(baseWritingDirection);
}

- (void)hoo_setLineHeightMultiple:(float)lineHeightMultiple {
    [self hoo_setLineHeightMultiple:lineHeightMultiple range:NSMakeRange(0, self.length)];
}
- (void)hoo_setLineHeightMultiple:(float)lineHeightMultiple range:(NSRange)range {
    HooSetParagraphAttributeAtRange(lineHeightMultiple);
}

- (void)hoo_setParagraphSpacingBefore:(float)paragraphSpacingBefore {
    [self hoo_setParagraphSpacingBefore:paragraphSpacingBefore range:NSMakeRange(0, self.length)];
}
- (void)hoo_setParagraphSpacingBefore:(float)paragraphSpacingBefore range:(NSRange)range {
    HooSetParagraphAttributeAtRange(paragraphSpacingBefore);
}

- (void)hoo_setTabStops:(NSArray *)tabStops {
    [self hoo_setTabStops:tabStops range:NSMakeRange(0, self.length)];
}
- (void)hoo_setTabStops:(NSArray *)tabStops range:(NSRange)range {
    HooSetParagraphAttributeAtRange(tabStops);
}

- (void)hoo_setDefaultTabInterval:(float)defaultTabInterval {
    [self hoo_setDefaultTabInterval:defaultTabInterval range:NSMakeRange(0, self.length)];
}
- (void)hoo_setDefaultTabInterval:(float)defaultTabInterval range:(NSRange)range {
    HooSetParagraphAttributeAtRange(defaultTabInterval);
}


@end
