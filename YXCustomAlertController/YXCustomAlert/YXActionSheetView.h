//
//  YXActionSheetView.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/6.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Edge.h"

@class YXAlertAction,YXAlertLayout;
@interface YXActionSheetView : UIView

//UI
@property (nonatomic, strong, nonnull) YXAlertLayout *layout;

/**
 上部视图包含titleLabel和messageLabel
 */
@property (nonatomic, strong, nonnull) UIView *labelView;


+ (instancetype _Nullable)actionSheetViewWith:(nullable NSString *)title message:(nullable NSString *)message;

- (void)addAction:(YXAlertAction *_Nullable)action;

@end
