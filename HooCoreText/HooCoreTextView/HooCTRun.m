//
//  HooCTRun.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/11.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "HooCTRun.h"
#import "HooTextAttachment.h"

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

- (CGPoint)position {
    CGPoint runPosition = CGPointZero;
    CTRunGetPositions(_runRef, CFRangeMake(0, 1), &runPosition);
    return runPosition;
}

- (HooCTRunDelegate *)runDelegate {
    NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(_runRef);
    CTRunDelegateRef runDelegateRef = (__bridge CTRunDelegateRef)[attributes objectForKey:@"CTRunDelegate"];
    HooCTRunDelegate *runDelegate = CTRunDelegateGetRefCon(runDelegateRef);
    return runDelegate;
}

- (HooTextAttachment *)textAttachment {
    NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(_runRef);
    HooTextAttachment *textAttachment = [attributes objectForKey:kHooTextAttachmentAttributeName];
    return textAttachment;
}

- (NSString *)description {
    NSString *des = [NSString stringWithFormat:@"<HooCTRun: %p> positon:%@ ascent:%f descent:%f leading:%f width:%f runDelegate:%p textAttachment:%p",self,NSStringFromCGPoint(self.position),self.ascent,self.descent,self.leading,self.width,self.runDelegate,self.textAttachment];
    return des;
}

- (void)dealloc {
    CFRelease(_runRef);  //oc对象与cf对象的生命周期保持一致,以防止中途释放
}

@end
