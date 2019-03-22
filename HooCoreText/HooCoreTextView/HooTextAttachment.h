//
//  HooTextAttachment.h
//  HooCoreText
//
//  Created by 汪启航 on 2019/3/22.
//  Copyright © 2019年 q.h. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kHooTextAttachmentAttributeName;

NS_ASSUME_NONNULL_BEGIN

@interface HooTextAttachment : NSObject

@property (nonatomic,strong) id content;
@property (nonatomic) UIEdgeInsets contentInsets;

//@property (nonatomic)

- (instancetype)initWithContent:(id)content;
@end

NS_ASSUME_NONNULL_END
