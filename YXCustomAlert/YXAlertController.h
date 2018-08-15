//
//  YXAlertController.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXAlertAction.h"

#import "YXAlertLayout.h"

typedef NS_ENUM(NSInteger, YXAlertControllerStyle) {
    YXAlertControllerStyleAlert = 0,
    YXAlertControllerStyleActionSheet
};


@interface YXAlertController : UIViewController

//alertController的color&fontSet
@property (nonatomic, strong, nonnull) YXAlertLayout *layout;

@property (nonatomic, assign) YXAlertControllerStyle style;

+ (instancetype _Nullable )alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message style:(YXAlertControllerStyle)style;

//修改色值和字体之后 使用此方法
- (void)layoutSettings;

- (void)addAction:(YXAlertAction *_Nonnull)action;

- (void)presentFromViewController:(UIViewController *_Nullable)fromViewController animated:(BOOL)flag completion:(void (^_Nullable)(void))completion;

- (void)dismissWithAnimation:(BOOL)flag completion:(void (^_Nullable)(void))completion;

@end

