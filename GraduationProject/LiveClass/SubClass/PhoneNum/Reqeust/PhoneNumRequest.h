//
//  PhoneNumRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//数据请求

#import <Foundation/Foundation.h>
typedef void (^SucessBlock)(NSDictionary*dict);
@interface PhoneNumRequest : NSObject

+(instancetype)shareInstance;
/**
 * @brief  查询电话号码
 * @param phoneNum String
 */
-(void)searchThePhoneNum:(NSString*)phoneNum sucess:(SucessBlock)sucess;

@end
