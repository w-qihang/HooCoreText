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
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    NSArray *arr = (__bridge NSArray *)CTLineGetGlyphRuns(_lineRef);
    for (int i=0;i<arr.count;i++) {
        CTRunRef runRef = (__bridge CTRunRef)arr[i];
        HooCTRun *run = [[HooCTRun alloc] initWithRun:runRef];
        [mArr addObject:run];
    }
    return [mArr copy];
}
- (void)dealloc {
    CFRelease(_lineRef);
}
@end
