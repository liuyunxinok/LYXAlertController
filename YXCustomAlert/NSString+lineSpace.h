//
//  NSString+lineSpace.h
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/6.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (lineSpace)


/**
 调整行间距

 @param font 字体
 @param string 文本
 @param maxWidth 文本最大显示宽度
 @param lineSpace 行距
 @return 富文本
 */
+ (NSAttributedString *)setLableLineMarginWithLableFont:(UIFont *)font andString:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace;

/**
 计算带有行间距的文本高度

 @param font 字体
 @param string 文本
 @param maxWidth 文本最大显示宽度
 @param lineSpace 行距
 @return 文本高度
 */
+ (CGFloat)heightForLableTextAndLineSapceWithFont:(UIFont *)font string:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace;

@end
