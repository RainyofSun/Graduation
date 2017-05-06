//
//  NewsListVC.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseVC.h"

@interface NewsListVC : BaseVC

//数据源
@property(nonatomic,strong)NSMutableArray* data;

//暴露请求数据的接口
-(void)loadNewsDataWithType:(NSString*)type;

@end
