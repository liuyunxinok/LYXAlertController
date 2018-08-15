//
//  YXAlertAction.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXAlertAction,YXAlertLayout;


typedef NS_ENUM(NSInteger,YXAlertActionStyle) {
    YXAlertActionStyleDefault = 0,
    YXAlertActionStyleCancel,
    YXAlertActionStyleDone
};

typedef void(^YXAlertActionHandler)(YXAlertAction *_Nonnull);


@interface YXAlertAction : UIButton

/**
 按钮title
 */
@property (nonatomic, copy, nullable) NSString *title;


@property (nonatomic, assign) YXAlertActionStyle style;

@property (nonatomic, copy, nullable) YXAlertActionHandler handler;

//设置按钮UI属性
- (void)setActionLayout:(YXAlertLayout *_Nonnull)layout;

//获取actionLayout
- (YXAlertLayout *_Nonnull)getActionLayout;


+ (instancetype _Nonnull )actionWithTitle:(nullable NSString *)title style:(YXAlertActionStyle)style handler:(void (^ __nullable)(YXAlertAction * _Nonnull action))hanlder;

@end
