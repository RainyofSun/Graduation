//
//  GroupBuyingModel.h
//  GraduationProject
//
//  Created by MS on 17/3/23.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface GroupBuyingModel : WBBaseModel

//店名
@property(nonatomic,copy)NSString* name;
//所属城市
@property(nonatomic,copy)NSString* city;
//所属区域
@property(nonatomic,copy)NSString* area;
//详细地址
@property(nonatomic,copy)NSString* address;
//坐标
@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;
//联系电话
@property(nonatomic,copy)NSString* phone;
//星级
@property(nonatomic,assign)float stars;
//人均消费
@property(nonatomic,copy)NSString* avg_price;
//图片
@property(nonatomic,copy)NSString* photos;
//标签
@property(nonatomic,copy)NSString* tags;
//总评论数
@property(nonatomic,assign)int all_remarks;
//产品评分
@property(nonatomic,copy)NSString* product_rating;
//环境评分
@property(nonatomic,copy)NSString* environment_rating;
//服务评分
@property(nonatomic,copy)NSString* service_rating;
//推荐产品
@property(nonatomic,copy)NSString* recommended_products;
//推荐菜色
@property(nonatomic,copy)NSString* recommended_dishes;
//周边美食
@property(nonatomic,copy)NSString* nearby_shops;

@end
