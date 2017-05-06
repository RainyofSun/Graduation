//
//  TvShowVC.h
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseVC.h"

@interface TvShowVC : BaseVC

@property(nonatomic,strong)NSMutableArray* data;
-(void)loadChannelWithId:(NSString*)pId;

@end
