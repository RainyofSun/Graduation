//
//  NewsModel.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

#pragma mark - 获取文本布局
+(YYTextLayout*)textLayout:(NSString*)string size:(CGSize)size{
    //创建文本容器
    YYTextContainer* container = [YYTextContainer containerWithSize:size];
    container.maximumNumberOfRows = 0;
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    //生成排版结果
    YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attStr];
    return textLayout;
}

@end
