//
//  YXTableViewCell.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/6.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "YXTableViewCell.h"
#import "YXAlertAction.h"

#import "UIView+Edge.h"
#import "YXAlertLayout.h"

@interface YXTableViewCell()

@property (nonatomic, strong) UIView *line;

@end

@implementation YXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(YXTableViewCellStyle)type{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //不知道为啥，cell的frame为320 与tableView的宽度有偏差 故重设frame
        if (type == YXTableViewCellStyleAlert) {
            self.contentView.frame = CGRectMake(0, 0, WIDTHSCALE(270), 44.0);
        }else{
            self.contentView.frame = CGRectMake(0, 0, SCREEN_W - left_X * 2, 57.0);
        }
        [self createUI];
    }
    return self;
}

- (void)loadDataWithAlertAction:(YXAlertAction *)action{
    if (action == nil) {
        return;
    }
    YXAlertLayout *layout = [action getActionLayout];
    switch (action.style) {
        case YXAlertActionStyleDone:
        {
            self.titleLabel.textColor = layout.doneActionTitleColor;
            self.titleLabel.font = layout.doneActionTitleFont;
            self.backgroundColor = layout.doneActionBackgroundColor;
        }
            break;
        case YXAlertActionStyleCancel:
        {
            self.titleLabel.textColor = layout.cancelActionTitleColor;
            self.titleLabel.font = layout.cancelActionTitleFont;
            self.backgroundColor = layout.cancelActionBackgroundColor;
        }
            break;
        default:
        {
            self.titleLabel.textColor = layout.defaultActionTitleColor;
            self.titleLabel.font = layout.defaultActionTitleFont;
            self.backgroundColor = layout.defaultActionBackgroundColor;
        }
            break;
    }
    
    self.titleLabel.text = action.title;
    self.line.backgroundColor = layout.lineColor;
}

- (void)setIsHidenLine:(BOOL)isHidenLine{
    _isHidenLine = isHidenLine;
    self.line.hidden = isHidenLine;
}

#pragma mark - createUI
- (void)createUI{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height - 0.5)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, 0.5)];
    self.line.backgroundColor = DEFAULT_LINECOLOR;
    self.line.hidden = self.isHidenLine;
    [self.contentView addSubview:self.line];
}


@end
