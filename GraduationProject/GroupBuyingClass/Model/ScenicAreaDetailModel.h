//
//  ScenicAreaDetailModel.h
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface ScenicAreaDetailModel : WBBaseModel

//景点名称
@property(nonatomic,copy)NSString* title;
//景点介绍
@property(nonatomic,copy)NSString* referral;
//景点图片
@property(nonatomic,copy)NSString* img;

@end
