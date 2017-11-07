//
//  NSString+lineSpace.m
//  YXCustomAlertController
//
//  Created by liuyunxin on 2017/11/6.
//  Copyright © 2017年 liuyunxin. All rights reserved.
//

#import "NSString+lineSpace.h"

@implementation NSString (lineSpace)

//调整行间距
+ (NSAttributedString *)setLableLineMarginWithLableFont:(UIFont *)font andString:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace
{
    if (!string.length) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    CGFloat offset = -(1.0/3 * lineSpace) - 1.0/3;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    //    // 对齐方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    //    // 首行缩进
    //    paragraphStyle.firstLineHeadIndent = 10.0f;
    //    // 头部缩进
    //    paragraphStyle.headIndent = 10.0f;
    //    // 尾部缩进
    //    paragraphStyle.tailIndent = -10.0f;
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSParagraphStyleAttributeName : paragraphStyle,
                            };
    //计算一行文本的高度
    CGFloat oneHeight = [@"测试Test" boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
    CGFloat rowHeight = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
    //如果超出一行，则offset=0;
    offset = rowHeight > oneHeight ? 0 : offset;
    return  [self getAttributedStringWithString:string lineSpace:lineSpace baselineOffset:offset];
}


+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace baselineOffset:(CGFloat)baselineOffset {
    if (string.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //对齐方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    // 调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    // 首行缩进
    paragraphStyle.firstLineHeadIndent = 5.0f;
    // 头部缩进
    paragraphStyle.headIndent = 5.0f;
    // 尾部缩进
    paragraphStyle.tailIndent = -5.0f;
    
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    // 设置文本偏移量
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:range];
    return attributedString;
}

//计算修改行距之后的富文本高度
+ (CGFloat)heightForLableTextAndLineSapceWithFont:(UIFont *)font string:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace{
    
    if (string.length == 0) {
        return 0;
    }
    // 计算文本的高度
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //对齐方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    // 调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    // 首行缩进
    paragraphStyle.firstLineHeadIndent = 5.0f;
    // 头部缩进
    paragraphStyle.headIndent = 5.0f;
    // 尾部缩进
    paragraphStyle.tailIndent = -5.0f;
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    //    NSAttributedString *attributeString = [self setLableLineMarginWithLableFont:font andString:string margin:margin lineSpace:lineSpace];
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options context:nil];
    if ((rect.size.height - font.lineHeight) <= lineSpace) {
        if ([self containChinese:string]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height- lineSpace);
        }
    }
    return rect.size.height;
}


//判断如果包含中文
+ (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}


@end
