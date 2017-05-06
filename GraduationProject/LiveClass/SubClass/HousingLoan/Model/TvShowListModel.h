//
//  TvShowListModel.h
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface TvShowListModel : WBBaseModel
/*频道名称*/
@property(nonatomic,copy)NSString* cName;
/*节目名称*/
@property(nonatomic,copy)NSString* pName;
/*播放链接*/
@property(nonatomic,copy)NSString* pUrl;
/*播出时间*/
@property(nonatomic,copy)NSString* time;

@end
