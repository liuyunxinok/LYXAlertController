//
//  YXAlertView.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXAlertAction,YXAlertLayout;
@interface YXAlertView : UIView

//UI
@property (nonatomic, strong, nonnull) YXAlertLayout *layout;

/**
 上部视图包含titleLabel和messageLabel
 */
@property (nonatomic, strong, nonnull) UIView *labelView;


@property (nonatomic, strong, readonly) NSArray <YXAlertAction *>* _Nullable actions;

+ (instancetype _Nullable)alertViewWith:(nullable NSString *)title message:(nullable NSString *)message;

- (void)addAction:(YXAlertAction *_Nullable)action;

@end
