//
//  HooCTRun.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCTRun.h"

@implementation HooCTRun
{
    CTRunRef _runRef;
}
- (instancetype)initWithRun:(CTRunRef)runRef {
    if(self = [super init]) {
        _runRef = CFRetain(runRef);
        _width = CTRunGetTypographicBounds(_runRef, CFRangeMake(0, 0), &_ascent, &_descent, &_leading);
    }
    return self;
}

- (void)dealloc {
    CFRelease(_runRef);
}

@end
