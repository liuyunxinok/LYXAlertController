//
//  YXAlertLayout.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/7.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "YXAlertLayout.h"

@implementation YXAlertLayout

- (instancetype)initWithStyle:(YXAlertLayoutStyle)style{
    if (self = [super init]) {
        [self configurePerprotiesWithStyle:style];
    }
    return self;
}

- (void)configurePerprotiesWithStyle:(YXAlertLayoutStyle)style{
    CGFloat titleFontSize = 17.0;
    CGFloat actionTitleSizeDefault = 17.0;
    CGFloat actionTitleSizeCancel = 17.0;
    CGFloat actionTitleSizeDone = 17.0;
    UIColor *titleColor = [UIColor blackColor];
    UIColor *messageColor = [UIColor blackColor];
    if (style == YXAlertLayoutStyleActionSheet) {
        titleFontSize = 13.0;
        actionTitleSizeDefault = 20.0;
        actionTitleSizeCancel = 20.0;
        actionTitleSizeDone = 20.0;
        titleColor = [UIColor colorWithWhite:0.56 alpha:1]; //跟系统一致
        messageColor = [UIColor colorWithWhite:0.56 alpha:1];
    }
    self.lineColor = DEFAULT_LINECOLOR;
    self.topViewBackgroundColor = [UIColor whiteColor];
    self.titleFont = [UIFont boldSystemFontOfSize:titleFontSize];
    self.messageFont = [UIFont systemFontOfSize:13.0];
    self.titleColor = titleColor;
    self.messageColor = messageColor;
    self.defaultActionTitleFont = [UIFont systemFontOfSize:actionTitleSizeDefault];
    self.cancelActionTitleFont = [UIFont boldSystemFontOfSize:actionTitleSizeCancel];
    self.doneActionTitleFont = [UIFont systemFontOfSize:actionTitleSizeDone];
    self.defaultActionTitleColor = DEFAULT_COLOR;
    self.cancelActionTitleColor = DEFAULT_COLOR;
    self.doneActionTitleColor = DEFAULT_COLOR;
    self.defaultActionBackgroundColor = [UIColor whiteColor];
    self.cancelActionBackgroundColor = [UIColor whiteColor];
    self.doneActionBackgroundColor = [UIColor whiteColor];
}

@end
