//
//  HooCTLine.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCTLine.h"
#import "HooCTRun.h"

@implementation HooCTLine
{
    CTLineRef _lineRef;
}
- (instancetype)initWithLine:(CTLineRef)lineRef {
    if(self = [super init]) {
        _lineRef = CFRetain(lineRef);
        CTLineGetTypographicBounds(_lineRef, &_ascent, &_descent, &_leading);
    }
    return self;
}
- (NSArray *)runArr {
    if(!_lineRef)
        return nil;
    CFArrayRef runs = CTLineGetGlyphRuns(_lineRef);
    if(!CFArrayGetCount(runs)) {
        return nil;
    }
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (int i=0;i<CFArrayGetCount(runs);i++) {
        CTRunRef runRef = CFArrayGetValueAtIndex(runs, i);
        HooCTRun *run = [[HooCTRun alloc] initWithRun:runRef];
        [mArr addObject:run];
    }
    return [mArr copy];
}

- (NSString *)description {
    NSString *des = [NSString stringWithFormat:@"<HooCTLine: %p> positon:%@ ascent:%f descent:%f leading:%f runCount:%ld",self,NSStringFromCGPoint(self.position),self.ascent,self.descent,self.leading,self.runArr.count];
    return des;
}

- (void)dealloc {
    CFRelease(_lineRef);
}
@end
