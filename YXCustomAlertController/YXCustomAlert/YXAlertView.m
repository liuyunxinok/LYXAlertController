//
//  YXAlertView.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "YXAlertController.h"

#import "YXAlertView.h"
#import "YXAlertAction.h"
#import "YXTableViewCell.h"

#import "NSString+lineSpace.h"
#import "UIView+Edge.h"

#define MAX_HEIGHT SCREEN_H - HEIGHTSCALE(18) * 2
#define LABEL_MAGIRN 2 //messageLabel与titleLabel之间的上下间距

@interface YXAlertView()<UITableViewDelegate,UITableViewDataSource>
//UI
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
//确定和取消按钮
@property (nonatomic, strong) YXAlertAction *cancelButton;
@property (nonatomic, strong) YXAlertAction *okButton;

/**
 过滤style == cancel ，剩下所有的按钮
 */
@property (nonatomic, strong) NSMutableArray <YXAlertAction *> *okButtons;

/**
 style == cancel 的所有按钮 注：一般只会设置一个
 */
@property (nonatomic, strong) NSMutableArray <YXAlertAction *> *cancelButtons;

//action多于2个时，列表显示
@property (nonatomic, strong) UITableView *actionListView;

//data
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray <YXAlertAction *> *actionArray;
@property (nonatomic, strong, readwrite) NSArray <YXAlertAction *> *actions;


@end

@implementation YXAlertView

- (instancetype)init{
    if (self = [super init]) {
        [self configureProperties];
        [self createUI];
    }
    return self;
}


- (void)configureProperties{
    
    self.layout = [[YXAlertLayout alloc] initWithStyle:YXAlertLayoutStyleAlert];
    //设置圆角
    self.layer.cornerRadius = WIDTHSCALE(10);
    self.layer.masksToBounds = YES;
    //actionArray
    self.actionArray = [NSMutableArray array];
    self.okButtons = [NSMutableArray array];
    self.cancelButtons = [NSMutableArray array];
}

+ (instancetype)alertViewWith:(NSString *)title message:(NSString *)message{
    YXAlertView *alertView = [[YXAlertView alloc] init];
    if (message.length > 0 && title.length > 0) {
        alertView.title = title;
        alertView.message = message;
    }else if(message.length == 0 && title.length > 0){
        alertView.title = title;
    }else if(message.length > 0 && title.length == 0){
        alertView.title = message;
    }else{
        NSLog(@"error: no title and message");
        return nil;
    }
    return alertView;
}

//修改数据源
- (void)addAction:(YXAlertAction *)action{
    if (action == nil) {
        return;
    }
    if (action.style != YXAlertActionStyleCancel) {
        [self.okButtons addObject:action];
    }else{
        [self.cancelButtons addObject:action];
        if (self.cancelButtons.count > 1) {
            NSException *excp = [NSException exceptionWithName:@"addActionError" reason:@"YXAlertController can only have one action with a style of YXAlertActionStyleCancel" userInfo:nil];
            [excp raise]; // 抛出异常
        }
    }
    [self.actionArray addObject:action];
    self.actions = [self.actionArray copy];
    if (self.actions.count < 3) {
        [self setActionUI];
    }else{
        [self.actionArray removeAllObjects];
        [self.actionArray addObjectsFromArray:self.okButtons];
        [self.actionArray addObjectsFromArray:self.cancelButtons];
        self.actions = [self.actionArray copy];
        [self.okButton removeFromSuperview];
        [self.cancelButton removeFromSuperview];
        [self addSubview:self.actionListView];
        [self.actionListView reloadData];
    }
}


#pragma mark - UITableViewDataSource / UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifer = @"alertViewCell";
    YXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (cell == nil) {
        cell = [[YXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifer cellType:YXTableViewCellStyleAlert];
    }
    YXAlertAction *action = self.actions[indexPath.row];
    [cell loadDataWithAlertAction:action];
    cell.isHidenLine = indexPath.row == self.actions.count - 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YXAlertAction *action = self.actions[indexPath.row];
    action.handler ? action.handler(action) : nil;
    YXAlertController *alertController = (YXAlertController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [alertController dismissWithAnimation:YES completion:nil];
}

#pragma mark - text&font&colorSet
- (void)setLayout:(YXAlertLayout *)layout{
    if (layout == nil) {
        return;
    }
    _layout = layout;
    self.backgroundColor = layout.lineColor;
    //设置action的layout
    for (YXAlertAction *action in self.actions) {
        [action setActionLayout:layout];
    }
    [self.actionListView reloadData];
    self.labelView.backgroundColor = layout.topViewBackgroundColor;
    self.titleLabel.font = layout.titleFont;
    self.titleLabel.textColor = layout.titleColor;
    self.messageLabel.font = layout.messageFont;
    self.messageLabel.textColor = layout.messageColor;

}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.attributedText = [NSString setLableLineMarginWithLableFont:self.layout.titleFont andString:title maxWidth:WIDTHSCALE(238) lineSpace:5];
}

- (void)setMessage:(NSString *)message{
    _message = message;
    self.messageLabel.attributedText = [NSString setLableLineMarginWithLableFont:self.layout.messageFont andString:message maxWidth:WIDTHSCALE(238) lineSpace:3];
}

#pragma mark - createUI

- (void)createUI{
    
    self.labelView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        view;
    });
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = self.layout.titleFont;
        label.textColor = self.layout.titleColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self.labelView addSubview:label];
        label;
    });
    
    self.messageLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = self.layout.messageFont;
        label.textColor = self.layout.messageColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self.labelView addSubview:label];
        label;
    });
    
}

- (UITableView *)actionListView{
    if (_actionListView == nil) {
        _actionListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _actionListView.dataSource = self;
        _actionListView.delegate = self;
        _actionListView.rowHeight = 44.0;
        _actionListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _actionListView;
}

- (void)setActionUI{
    if (self.actions.count == 1) {
        YXAlertAction *action = self.actions.firstObject;
        self.cancelButton = action;
        [self addSubview:action];
    }else{
        //两个都是default
        if (self.okButtons.count == self.actions.count) {
            YXAlertAction *action = self.actions.lastObject;
            self.okButton = action;
            [self addSubview:action];
        }else{
            [self.cancelButton removeFromSuperview];
            for (YXAlertAction *action in self.actions) {
                if (action.style == YXAlertActionStyleCancel) {
                    self.cancelButton = action;
                }else{
                    self.okButton = action;
                }
                [self addSubview:action];
            }
        }
    }
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat titleHeight = [NSString heightForLableTextAndLineSapceWithFont:self.layout.titleFont string:self.title maxWidth:WIDTHSCALE(238) lineSpace:5];
    CGFloat messageHeight = [NSString heightForLableTextAndLineSapceWithFont:self.layout.messageFont string:self.message maxWidth:WIDTHSCALE(238) lineSpace:3];
    CGFloat titleY = HEIGHTSCALE(18.5);
    //文本高度
    CGFloat alertTopHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
    //按钮高度
    CGFloat alertActionsHeight = self.actions.count > 2 ? self.actions.count * HEIGHTSCALE(44) : HEIGHTSCALE(44);
    
    if ((alertTopHeight + alertActionsHeight) > MAX_HEIGHT) {
        alertActionsHeight = MAX_HEIGHT - alertTopHeight;
        self.actionListView.scrollEnabled = YES;
        //当弹框实际高度大于最大高度时，并且有style == cancel的action，那么把tableView滚动到最底部，显示取消按钮
        if (self.cancelButtons.count > 0) {
            [self.actionListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.actions.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        //并调整titleLabel的y值
        titleY = HEIGHTSCALE(5);
        //更新文本高度
        alertTopHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
        
    }else{
        self.actionListView.scrollEnabled = NO;
    }
    //alertView
    self.frame = CGRectMake(0, 0, WIDTHSCALE(ALERT_WIDTH), alertTopHeight + alertActionsHeight);
    self.center = CGPointMake(SCREEN_W / 2, SCREEN_H / 2);
    
    self.labelView.frame = CGRectMake(0, 0, self.width, alertTopHeight);
    //title
    self.titleLabel.frame = CGRectMake(WIDTHSCALE(label_X), titleY, self.width - WIDTHSCALE(label_X) * 2, titleHeight);
    //message
    self.messageLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0), self.titleLabel.width, messageHeight);
    //留出0.5的线
    CGFloat actionsY = alertTopHeight + 0.5;
    
    //确定-取消按钮
    if (self.actions.count == 1) {
        self.cancelButton.frame = CGRectMake(0, actionsY, self.width, HEIGHTSCALE(44));
    }else if (self.actions.count == 2){
        self.cancelButton.frame = CGRectMake(0, actionsY, self.width / 2 - 0.5, HEIGHTSCALE(44));
        self.okButton.frame = CGRectMake(self.width / 2, actionsY, self.width / 2, HEIGHTSCALE(44));
    }else if (self.actions.count > 2){
        //按钮列表的frame
        self.actionListView.frame = CGRectMake(0, actionsY, self.width, self.actions.count > 2 ? alertActionsHeight : 0);
    }
}


@end
