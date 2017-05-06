//
//  CurrencyReqeust.h
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SucessBlock)(NSMutableArray* dataSource,NSString* updateTime);
@interface CurrencyReqeust : NSObject

+(instancetype)shareInstance;

/**
 * @brief 油价查询
 */
-(void)oilPriceQuerySucess:(SucessBlock)sucess;

@end
