//
//  YXAlertAction.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "YXAlertController.h"
#import "YXAlertAction.h"
#import "UIView+Edge.h"

@interface YXAlertAction()

@property (nonatomic, strong) YXAlertLayout *layout;

@end

@implementation YXAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(YXAlertActionStyle)style handler:(void (^)(YXAlertAction * _Nonnull))hanlder{
    YXAlertAction *button = [YXAlertAction buttonWithType:UIButtonTypeCustom];
    [button configureProperties];
    button.handler = hanlder;
    button.style = style;
    button.title = title;
    return button;
}

- (void)configureProperties
{
    [self addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - action
- (void)buttonDidClick
{
    self.handler ? self.handler(self) : nil;
    YXAlertController *alertController = (YXAlertController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [alertController dismissWithAnimation:YES completion:nil];
}


#pragma mark - setUI

- (void)setActionLayout:(YXAlertLayout *)layout{
    if (layout == nil) {
        return;
    }
    self.layout = layout;
    switch (self.style) {
        case YXAlertActionStyleCancel:
        {
            [self setTitleColor:layout.cancelActionTitleColor forState:UIControlStateNormal];
            self.backgroundColor = layout.cancelActionBackgroundColor;
            self.titleLabel.font = layout.cancelActionTitleFont;

        }
            break;
        case YXAlertActionStyleDone:
        {
            [self setTitleColor:layout.doneActionTitleColor forState:UIControlStateNormal];
            self.backgroundColor = layout.doneActionBackgroundColor;
            self.titleLabel.font = layout.doneActionTitleFont;
            
        }
            break;
        default:
        {
            [self setTitleColor:layout.defaultActionTitleColor forState:UIControlStateNormal];
            self.backgroundColor = layout.defaultActionBackgroundColor;
            self.titleLabel.font = layout.defaultActionTitleFont;
        }
            break;
    }
}

- (YXAlertLayout *)getActionLayout{
    return self.layout;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}



@end
