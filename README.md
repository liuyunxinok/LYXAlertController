# YXAlertController
为解决UIAlertController的UI（字体颜色，action背景色,字体大小等）设置局限，故自己封装一个YXAlertController，可以随意进行颜色和字体设置。样式大小，title和message的行距缩进与系统样式保持一致。
示例：

![YXAlertController-alert.png](http://upload-images.jianshu.io/upload_images/2962939-82c32c80cdc50102.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![YXAlertController-actionSheet.png](http://upload-images.jianshu.io/upload_images/2962939-bd9f4f7cd5d2ff51.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
## 一、集成方式：
#### 1.可以下载下来把YXCustomAlert文件夹拖进项目中
#### 2.可以用cocoaPods
                pod 'LYXAlertController' 
## 二、使用
### 1.导入头文件 #import <YXAlertController.h>
### 2.创建alertController跟UIAlertController的创建方式一样，支持alert和actionSheet,下面拿alert举例：
	YXAlertController *alertController = [YXAlertController alertControllerWithTitle:@"爱尔兰雪、土耳其蓝、莫斯科眼泪。我都收藏在小小的太阳里、还有晴天和微笑。波斯湾海、维也纳厅、阿拉伯传说。我都纪念在厚厚的相集里。还有七粉和公主" message:@"蔷薇开出的花朵没有芬芳、想念一个人、怀念一段伤、不流泪、不说话" style:YXAlertControllerStyleAlert];
	YXAlertAction *cancel = [YXAlertAction actionWithTitle:@"考虑一下" style:1 handler:^(YXAlertAction * _Nonnull action) {
	NSLog(@"custom:点击了取消");
	}];

	YXAlertAction *done = [YXAlertAction actionWithTitle:@"赞一个" style:2 handler:^(YXAlertAction * _Nonnull action) {
	NSLog(@"custom:点击了确定");
	}];
### 3.YXAlertCotroller 有一个layout属性，修改可以进行UI设置，以达到预期的样式。
	@property (nonatomic, strong, nonnull) YXAlertLayout *layout;

	//自定义颜色设置
	alertController.layout.doneActionTitleColor = [UIColor redColor];
	alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
	alertController.layout.doneActionBackgroundColor = [UIColor yellowColor];
	alertController.layout.lineColor = [UIColor redColor];
	alertController.layout.topViewBackgroundColor = [UIColor orangeColor];
	alertController.layout.titleColor = [UIColor whiteColor];
	[alertController layoutSettings];

### 4.添加action
	[alertController addAction:cancel];
	[alertController addAction:done];

### 5.present 这里使用自定义的方法
	[alertController presentFromViewController:self animated:YES completion:nil];



