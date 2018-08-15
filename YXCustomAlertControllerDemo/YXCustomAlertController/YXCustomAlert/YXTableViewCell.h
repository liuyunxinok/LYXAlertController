//
//  YXTableViewCell.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/6.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YXTableViewCellStyle) {
    YXTableViewCellStyleAlert = 0,
    YXTableViewCellStyleActionSheet
};

@class YXAlertAction;
@interface YXTableViewCell : UITableViewCell

/**
 是否隐藏分割线 default NO
 */
@property (nonatomic, assign) BOOL isHidenLine;

/**
 标题
 */
@property (nonatomic, strong, nonnull) UILabel *titleLabel;

/**
 加载数据

 @param action 弹框动作
 */
- (void)loadDataWithAlertAction:(YXAlertAction *_Nonnull)action;


- (instancetype _Nullable )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *_Nonnull)reuseIdentifier cellType:(YXTableViewCellStyle)type;

@end
