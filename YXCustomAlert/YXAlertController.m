//
//  YXAlertController.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "YXAlertController.h"

#import "YXAlertView.h"
#import "YXActionSheetView.h"

static UIWindow *alertWindow;

@interface YXAlertController ()

@property (nonatomic, weak) UIViewController *fromController;
@property (nonatomic, strong) UIView *blackCoverView; //黑色遮罩
@property (nonatomic, strong) YXAlertView *alertView; //alertView
@property (nonatomic, strong) YXActionSheetView *actionSheetView; //actionSheetView


@end

@implementation YXAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message style:(YXAlertControllerStyle)style{
    YXAlertController *alertController = [[YXAlertController alloc] init];
    alertController.style = style;
    YXAlertLayoutStyle layoutStyle = style == YXAlertLayoutStyleAlert ? YXAlertLayoutStyleAlert : YXAlertLayoutStyleActionSheet;
    alertController.layout = [[YXAlertLayout alloc] initWithStyle:layoutStyle];
    [alertController.view addSubview:alertController.blackCoverView];
    if (style == YXAlertControllerStyleAlert) {
        alertController.alertView = [YXAlertView alertViewWith:title message:message];
        [alertController.view addSubview:alertController.alertView];
    }else{
        alertController.actionSheetView = [YXActionSheetView actionSheetViewWith:title message:message];
        [alertController.view addSubview:alertController.actionSheetView];
    }
    [alertController layoutSettings];
    return alertController;
}

- (void)layoutSettings{
    if (self.style == YXAlertControllerStyleAlert) {
        self.alertView.layout = self.layout;
    }else{
        self.actionSheetView.layout = self.layout;
    }
}

- (void)addAction:(YXAlertAction *)action{
    [action setActionLayout:self.layout];
    if (self.style == YXAlertControllerStyleAlert) {
        [self.alertView addAction:action];
    }else{
        [self.actionSheetView addAction:action];
    }
}

#pragma mark - color&FontSet


#pragma mark - createUI

- (UIView *)blackCoverView{
    if (_blackCoverView == nil) {
        self.blackCoverView = ({
            UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
            coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
            coverView.alpha = 0;
            coverView;
        });
    }
    return _blackCoverView;
}

#pragma mark -
- (void)presentFromViewController:(UIViewController *)fromViewController animated:(BOOL)flag completion:(void (^)(void))completion{
    if (fromViewController == nil) {
        NSLog(@"error: fromViewController is nil! ");
        return;
    }
    self.fromController = fromViewController;
    
    if (alertWindow == nil) {
        alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.backgroundColor = [UIColor clearColor];
        alertWindow.windowLevel = UIWindowLevelAlert - 1;
    }
    
    alertWindow.rootViewController = self;
    
    //简单动画
    if (self.style == YXAlertControllerStyleAlert) {
        self.alertView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.blackCoverView.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.blackCoverView.alpha = 1;
        }];
    }else{
        CGFloat actionSheetY = self.actionSheetView.y;
        self.actionSheetView.y = actionSheetY + SCREEN_H;
        self.blackCoverView.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.actionSheetView.y = actionSheetY;
            self.blackCoverView.alpha = 1;
        }];
    }
    
    [alertWindow makeKeyAndVisible];
    
}

- (void)dismissWithAnimation:(BOOL)flag completion:(void (^)(void))completion{
    
    if (self.style == YXAlertControllerStyleAlert) {
            self.blackCoverView.alpha = 0;
            [self.alertView removeFromSuperview];
            [self.fromController.view.window makeKeyAndVisible];
            alertWindow.hidden = YES;
            self.fromController = nil;
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.actionSheetView.y += SCREEN_H;
            self.blackCoverView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.actionSheetView removeFromSuperview];
            [self.fromController.view.window makeKeyAndVisible];
            alertWindow.hidden = YES;
            self.fromController = nil;
        }];
    }
}

@end
