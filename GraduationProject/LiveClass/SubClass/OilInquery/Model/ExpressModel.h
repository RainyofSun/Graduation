//
//  ExpressModel.h
//  GraduationProject
//
//  Created by MS on 17/3/15.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBBaseModel.h"

@interface ExpressModel : WBBaseModel

/**快递状态*/
@property(nonatomic,copy)NSString* status;
/**快递时间*/
@property(nonatomic,copy)NSString* time;

@end
