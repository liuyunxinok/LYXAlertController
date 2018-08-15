//
//  YXActionSheetView.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/6.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "YXAlertController.h"

#import "YXActionSheetView.h"
#import "YXTableViewCell.h"
#import "YXAlertAction.h"

#import "NSString+lineSpace.h"

#define ACTIONSHEET_ROWHEIGHT 57.0
#define LABEL_WIDTH  323
#define LABLE_Y 13.5  //titlelabel的y值
#define LABEL_MAGIRN 10.5 //messageLabel与titleLabel之间的上下间距

@interface YXActionSheetView()<UITableViewDataSource, UITableViewDelegate>

//UI
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//信息
@property (nonatomic, strong) UILabel *messageLabel;
//动作列表
@property (nonatomic, strong) UITableView *actionListView;
//标题，信息和动作列表之间的间隔线
@property (nonatomic, strong) UIView *line;

//data
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray <YXAlertAction *> *actionArray;
@property (nonatomic, strong, readwrite) NSArray <YXAlertAction *> *actions;

/**
 过滤style == cancel ，剩下所有的按钮
 */
@property (nonatomic, strong) NSMutableArray <YXAlertAction *> *okButtons;

/**
 style == cancel 的所有按钮 注：一般只会设置一个
 */
@property (nonatomic, strong) NSMutableArray <YXAlertAction *> *cancelButtons;


@end


@implementation YXActionSheetView

- (instancetype)init{
    if (self = [super init]) {
        [self configureProperties];
        [self createUI];
    }
    return self;
}


- (void)configureProperties{
    
    //默认属性与系统一致
    self.layout = [[YXAlertLayout alloc] initWithStyle:YXAlertLayoutStyleActionSheet];
    //设置圆角
    self.layer.cornerRadius = WIDTHSCALE(10);
    self.layer.masksToBounds = YES;
    //actionArray
    self.actionArray = [NSMutableArray array];
    self.okButtons = [NSMutableArray array];
    self.cancelButtons = [NSMutableArray array];
}

+ (instancetype)actionSheetViewWith:(NSString *)title message:(NSString *)message{
    YXActionSheetView *actionSheetView = [[YXActionSheetView alloc] init];
    if (message.length > 0 && title.length > 0) {
        actionSheetView.title = title;
        actionSheetView.message = message;
    }else if(message.length == 0 && title.length > 0){
        actionSheetView.title = title;
    }else if(message.length > 0 && title.length == 0){
        actionSheetView.title = message;
    }else{
        NSLog(@"error: no title and message");
        return nil;
    }
    return actionSheetView;
}

//MARK: 添加动作
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
    if (self.actions.count > 1 && self.cancelButtons.count > 0) {
        [self.actionArray removeAllObjects];
        [self.actionArray addObjectsFromArray:self.okButtons];
        [self.actionArray addObjectsFromArray:self.cancelButtons];
        self.actions = [self.actionArray copy];
    }
    
    [self.actionListView reloadData];
}

#pragma mark - UITableViewDataSource&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"actionSheetViewCell";
    YXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[YXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier cellType:YXTableViewCellStyleActionSheet];
    }
    YXAlertAction *action = self.actionArray[indexPath.row];
    [cell loadDataWithAlertAction:action];
    cell.isHidenLine = indexPath.row == self.actionArray.count - 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YXAlertAction *action = self.actions[indexPath.row];
    action.handler ? action.handler(action) : nil;
    YXAlertController *alertController = (YXAlertController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [alertController dismissWithAnimation:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat titleHeight = [NSString heightForLableTextAndLineSapceWithFont:self.layout.titleFont string:self.title maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat messageHeight = [NSString heightForLableTextAndLineSapceWithFont:self.layout.messageFont string:self.message maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat titleY = HEIGHTSCALE(LABLE_Y);
    //文本高度
    CGFloat headerHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.labelView;
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
    self.line.backgroundColor = layout.lineColor;
    self.titleLabel.font = layout.titleFont;
    self.titleLabel.textColor = layout.titleColor;
    self.messageLabel.font = layout.messageFont;
    self.messageLabel.textColor = layout.messageColor;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.attributedText = [NSString setLableLineMarginWithLableFont:self.layout.titleFont andString:title maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
}

- (void)setMessage:(NSString *)message{
    _message = message;
    self.messageLabel.attributedText = [NSString setLableLineMarginWithLableFont:self.layout.messageFont andString:message maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
}


#pragma mark - createUI

- (void)createUI{
    
    self.labelView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
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
    
    self.line = ({
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = self.layout.lineColor;
        [self.labelView addSubview:line];
        line;
    });
    
}

- (UITableView *)actionListView{
    if (_actionListView == nil) {
        _actionListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _actionListView.dataSource = self;
        _actionListView.delegate = self;
        _actionListView.rowHeight = ACTIONSHEET_ROWHEIGHT;
        _actionListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_actionListView];
    }
    return _actionListView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat titleHeight = [NSString heightForLableTextAndLineSapceWithFont:self.layout.titleFont string:self.title maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat messageHeight = [NSString heightForLableTextAndLineSapceWithFont:self.layout.messageFont string:self.message maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat titleY = HEIGHTSCALE(LABLE_Y);
    //文本高度
    CGFloat headerHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
    
    //按钮高度
    CGFloat actionsHeight = self.actions.count * ACTIONSHEET_ROWHEIGHT;
    
    if ((headerHeight + actionsHeight) > SCREEN_H - 40) {
        actionsHeight = SCREEN_H - 40 - headerHeight;
        self.actionListView.scrollEnabled = YES;
        //当弹框实际高度大于最大高度时，并且有style == cancel的action，那么把tableView滚动到最底部，显示取消按钮
        if (self.cancelButtons.count > 0) {
            [self.actionListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.okButtons.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        //并调整titleLabel的y值
        titleY = HEIGHTSCALE(5);
        //更新文本高度
        headerHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
        
    }else{
        self.actionListView.scrollEnabled = NO;
    }
    self.frame = CGRectMake(WIDTHSCALE(left_X), SCREEN_H - headerHeight - actionsHeight - 20, SCREEN_W - WIDTHSCALE(left_X) * 2, headerHeight + actionsHeight);
    
    self.actionListView.frame = self.bounds;
    
    self.labelView.frame = CGRectMake(0, 0, self.width, headerHeight);
    //title
    self.titleLabel.frame = CGRectMake(WIDTHSCALE(label_X), titleY, WIDTHSCALE(LABEL_WIDTH), titleHeight);
    //message
    self.messageLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0), self.titleLabel.width, messageHeight);
    //分割线
    self.line.frame = CGRectMake(0, self.labelView.bottom - 0.5, self.labelView.width, 0.5);
}


@end
