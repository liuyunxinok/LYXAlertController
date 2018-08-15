//
//  ViewController.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/3.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "ViewController.h"

#import "YXAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    [button1 setTitle:@"systemAlert" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(systemAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 200, 50)];
    [button2 setTitle:@"customAlert" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(customAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    [button3 setTitle:@"systemActionSheet" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(systemActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 350, 200, 50)];
    [button4 setTitle:@"customActionSheet" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(customActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
}


- (void)systemAlert{
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"爱尔兰雪、土耳其蓝、莫斯科眼泪。我都收藏在小小的太阳里、还有晴天和微笑。波斯湾海、维也纳厅、阿拉伯传说。我都纪念在厚厚的相集里。还有七粉和公主" message:@"蔷薇开出的花朵没有芬芳、想念一个人、怀念一段伤、不流泪、不说话" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"考虑一下" style:1 handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"system:点击了取消");
    }];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"赞一个" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"system:点击了确定");
    }];
    
    //    UIAlertAction *done1 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    UIAlertAction *done2 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    UIAlertAction *done3 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    UIAlertAction *done4 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done5 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done6 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done7 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done8 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done9 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done10 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    
    
    
    [alerVC addAction:cancel];
    [alerVC addAction:done];
    //    [alerVC addAction:done1];
    //    [alerVC addAction:done2];
    //    [alerVC addAction:done3];
    //    [alerVC addAction:done4];
    //    [alerVC addAction:done5];
    //    [alerVC addAction:done6];
    //    [alerVC addAction:done7];
    //    [alerVC addAction:done8];
    //    [alerVC addAction:done9];
    //    [alerVC addAction:done10];
    
    
    [self presentViewController:alerVC animated:YES completion:nil];
}

- (void)customAlert{
    
    YXAlertController *alertController = [YXAlertController alertControllerWithTitle:@"爱尔兰雪、土耳其蓝、莫斯科眼泪。我都收藏在小小的太阳里、还有晴天和微笑。波斯湾海、维也纳厅、阿拉伯传说。我都纪念在厚厚的相集里。还有七粉和公主" message:@"蔷薇开出的花朵没有芬芳、想念一个人、怀念一段伤、不流泪、不说话" style:YXAlertControllerStyleAlert];
    YXAlertAction *cancel = [YXAlertAction actionWithTitle:@"考虑一下" style:1 handler:^(YXAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了取消");
    }];
    
    
    YXAlertAction *done = [YXAlertAction actionWithTitle:@"赞一个" style:2 handler:^(YXAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了确定");
    }];
    
//    YXAlertAction *done1 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//
//    YXAlertAction *done2 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//    YXAlertAction *done3 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];YXAlertAction *done4 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//    YXAlertAction *done5 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//    YXAlertAction *done6 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//    YXAlertAction *done7 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//    YXAlertAction *done8 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
//    YXAlertAction *done9 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
//
//    }];
    //自定义颜色设置
    alertController.layout.doneActionTitleColor = [UIColor redColor];
    alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
    alertController.layout.doneActionBackgroundColor = [UIColor yellowColor];
    alertController.layout.lineColor = [UIColor redColor];
    alertController.layout.topViewBackgroundColor = [UIColor orangeColor];
    alertController.layout.titleColor = [UIColor whiteColor];
    [alertController layoutSettings];
    
    [alertController addAction:cancel];
    [alertController addAction:done];
//    [alertController addAction:done1];
//    [alertController addAction:done2];
    //    [alertController addAction:done3];
    //    [alertController addAction:done4];
    //    [alertController addAction:done5];
    //    [alertController addAction:done6];
    //    [alertController addAction:done7];
    //    [alertController addAction:done8];
    //    [alertController addAction:done9];
    
    [alertController presentFromViewController:self animated:YES completion:nil];
}

- (void)systemActionSheet{
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"爱尔兰雪、土耳其蓝、莫斯科眼泪。我都收藏在小小的太阳里、还有晴天和微笑。波斯湾海、维也纳厅、阿拉伯传说。我都纪念在厚厚的相集里。还有七粉和公主" message:@"蔷薇开出的花朵没有芬芳、想念一个人、怀念一段伤、不流泪、不说话" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"考虑一下" style:1 handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"system:点击了取消");
    }];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"赞一个" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"system:点击了确定");
    }];
    
    //    UIAlertAction *done1 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    UIAlertAction *done2 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    UIAlertAction *done3 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    UIAlertAction *done4 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done5 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done6 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done7 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done8 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done9 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    UIAlertAction *done10 = [UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    
    
    
    [alerVC addAction:cancel];
    [alerVC addAction:done];
    //    [alerVC addAction:done1];
    //    [alerVC addAction:done2];
    //    [alerVC addAction:done3];
    //    [alerVC addAction:done4];
    //    [alerVC addAction:done5];
    //    [alerVC addAction:done6];
    //    [alerVC addAction:done7];
    //    [alerVC addAction:done8];
    //    [alerVC addAction:done9];
    //    [alerVC addAction:done10];
    
    
    [self presentViewController:alerVC animated:YES completion:nil];
    
}

- (void)customActionSheet{
    
    YXAlertController *alertController = [YXAlertController alertControllerWithTitle:@"爱尔兰雪、土耳其蓝、莫斯科眼泪。我都收藏在小小的太阳里、还有晴天和微笑。波斯湾海、维也纳厅、阿拉伯传说。我都纪念在厚厚的相集里。还有七粉和公主" message:@"蔷薇开出的花朵没有芬芳、想念一个人、怀念一段伤、不流泪、不说话" style:YXAlertControllerStyleActionSheet];
    YXAlertAction *cancel = [YXAlertAction actionWithTitle:@"考虑一下" style:1 handler:^(YXAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了取消");
    }];
    
    
    YXAlertAction *done = [YXAlertAction actionWithTitle:@"赞一个" style:2 handler:^(YXAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了确定");
    }];
    
    //    YXAlertAction *done1 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //
    //    YXAlertAction *done2 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //    YXAlertAction *done3 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];YXAlertAction *done4 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //    YXAlertAction *done5 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //    YXAlertAction *done6 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //    YXAlertAction *done7 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //    YXAlertAction *done8 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //    YXAlertAction *done9 = [YXAlertAction actionWithTitle:@"确认" style:0 handler:^(YXAlertAction * _Nonnull action) {
    //
    //    }];
    //自定义颜色设置
    alertController.layout.doneActionTitleColor = [UIColor redColor];
    alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
    alertController.layout.doneActionBackgroundColor = [UIColor yellowColor];
    alertController.layout.lineColor = [UIColor redColor];
    alertController.layout.topViewBackgroundColor = [UIColor orangeColor];
    alertController.layout.titleColor = [UIColor whiteColor];
    [alertController layoutSettings];
    
    [alertController addAction:cancel];
    [alertController addAction:done];
    //    [alertController addAction:done1];
    //    [alertController addAction:done2];
    //    [alertController addAction:done3];
    //    [alertController addAction:done4];
    //    [alertController addAction:done5];
    //    [alertController addAction:done6];
    //    [alertController addAction:done7];
    //    [alertController addAction:done8];
    //    [alertController addAction:done9];
    
    [alertController presentFromViewController:self animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
