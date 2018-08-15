//
//  YXAlertLayout.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/7.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+Edge.h"

typedef NS_ENUM(NSInteger,YXAlertLayoutStyle){
    YXAlertLayoutStyleAlert = 0,
    YXAlertLayoutStyleActionSheet
};

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define WIDTHSCALE(awidth) [UIScreen mainScreen].bounds.size.width / 375 * awidth
#define HEIGHTSCALE(aheight) [[UIScreen mainScreen] bounds].size.height / 667 * aheight
#define DEFAULT_COLOR [UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]
#define DEFAULT_LINECOLOR [UIColor colorWithRed:0 green:0 blue:0.31 alpha:0.05]
#define ALERT_WIDTH 270
#define left_X 10  //actionSheetView的x坐标
#define label_X 16  //lable的x坐标
#define MAX_Y 30    //actionSheet最大高度时的Y坐标

@interface YXAlertLayout : NSObject

/**
 分割线颜色  default R:0 G:0 B:0.31 A:0.05
 */
@property (nonatomic, strong, nullable) UIColor *lineColor;

/**
 alertView分割线上部视图的背景颜色 default whiteColor
 */
@property (nonatomic, strong, nullable) UIColor *topViewBackgroundColor;

/**
 titleFont 默认为17 加粗
 */
@property (nonatomic, strong, nullable) UIFont *titleFont;

/**
 messageFont 默认为13 常规
 */
@property (nonatomic, strong, nullable) UIFont *messageFont;

/**
 titleColor default blackColor
 */
@property (nonatomic, strong, nullable) UIColor *titleColor;

/**
 messageTextColor default blackColor
 */
@property (nonatomic, strong, nullable) UIColor *messageColor;


/**
  style == default 按钮字体颜色 默认蓝色
 */
@property (nonatomic, strong, nullable) UIColor *defaultActionTitleColor;

/**
 style == cancel 按钮字体颜色 默认蓝色
 */
@property (nonatomic, strong, nullable) UIColor *cancelActionTitleColor;

/**
 style == done 按钮字体颜色 默认蓝色
 */
@property (nonatomic, strong, nullable) UIColor *doneActionTitleColor;


/**
 style == default 按钮字体大小 默认为17
 */
@property (nonatomic, strong, nullable) UIFont *defaultActionTitleFont;

/**
  style == cancel 按钮字体大小 默认为17
 */
@property (nonatomic, strong, nullable) UIFont *cancelActionTitleFont;

/**
 style == done 按钮字体大小 默认为17
 */
@property (nonatomic, strong, nullable) UIFont *doneActionTitleFont;

/**
  style == default 按钮背景颜色 default whiteColor
 */
@property (nonatomic, strong, nullable) UIColor *defaultActionBackgroundColor;

/**
  style == cancel 按钮背景颜色 default whiteColor
 */
@property (nonatomic, strong, nullable) UIColor *cancelActionBackgroundColor;

/**
  style == done 按钮背景颜色 default whiteColor
 */
@property (nonatomic, strong, nullable) UIColor *doneActionBackgroundColor;


- (instancetype _Nonnull )initWithStyle:(YXAlertLayoutStyle)style;



@end
