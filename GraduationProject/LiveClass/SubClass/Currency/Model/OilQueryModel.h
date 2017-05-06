//
//  OilQueryModel.h
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface OilQueryModel : WBBaseModel

/*城市*/
@property(nonatomic,copy)NSString* city;
/*汽油型号   key为汽油型号   value为汽油价格*/
@property(nonatomic,copy)NSString* b90;
@property(nonatomic,copy)NSString* b93;
@property(nonatomic,copy)NSString* b97;
@property(nonatomic,copy)NSString* b0;

@end
