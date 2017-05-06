//
//  IDCardReqeust.h
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//数据请求

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSDictionary*dict);
@interface IDCardReqeust : NSObject

+(instancetype)shareInstance;
/**
 * @brief 身份证查询请求成功
 * @param IdNum String 身份证号
 */
-(NSDictionary*)searchIdCardNum:(NSString*)IdNum sucess:(SucessBlock)sucess;

@end
