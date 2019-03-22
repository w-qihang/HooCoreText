//
//  HooTextAttachment.m
//  HooCoreText
//
//  Created by 汪启航 on 2019/3/22.
//  Copyright © 2019年 q.h. All rights reserved.
//

#import "HooTextAttachment.h"

NSString *const kHooTextAttachmentAttributeName = @"kHooTextAttachmentAttributeName";

@implementation HooTextAttachment

- (instancetype)initWithContent:(id)content {
    if(self = [super init]) {
        _content = content;
    }
    return self;
}

@end
