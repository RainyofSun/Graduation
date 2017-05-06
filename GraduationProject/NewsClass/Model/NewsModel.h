//
//  NewsModel.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"
#import <YYText.h>

@interface NewsModel : WBBaseModel

/***/
@property(nonatomic,copy)NSString* uniquekey;
/**文章标题*/
@property(nonatomic,copy)NSString* title;
/**发布时间*/
@property(nonatomic,copy)NSString* date;
/**类型*/
@property(nonatomic,copy)NSString* category;
/**娱乐名字*/
@property(nonatomic,copy)NSString* author_name;
/**文章详情*/
@property(nonatomic,copy)NSString* url;
/**文章封面*/
@property(nonatomic,copy)NSString* thumbnail_pic_s;
@property(nonatomic,copy)NSString* thumbnail_pic_s02;
@property(nonatomic,copy)NSString* thumbnail_pic_s03;
#pragma mark - 获取文字布局
+(YYTextLayout*)textLayout:(NSString*)string size:(CGSize)size;
@end
