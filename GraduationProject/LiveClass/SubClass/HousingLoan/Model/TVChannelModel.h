//
//  TVChannelModel.h
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface TVChannelModel : WBBaseModel

/*频道名称*/
@property(nonatomic,copy)NSString* channelName;
/*分类ID*/
@property(nonatomic,copy)NSString* pId;
/*频道代码*/
@property(nonatomic,copy)NSString* rel;
/*播放链接*/
@property(nonatomic,copy)NSString* url;

@end
