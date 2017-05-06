//
//  PhoneChargeReqeust.h
//  GraduationProject
//
//  Created by MS on 17/3/13.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SucessBlock)(NSDictionary*dict);

typedef NS_ENUM(NSUInteger,PhoneRechargetype) {
    /**话费充值*/
    phoneR = 1,
    /**流量充值*/
    flowR
};
@interface PhoneChargeReqeust : NSObject

+(instancetype)shareInstance;
/**
 * 检测手机是否可以充值
 */
-(void)checkThePhoneNum:(NSString*)phoneNum money:(NSString*)money sucess:(SucessBlock)sucess;
/**
 * 根据手机号和面值查询商品
 */
-(void)searchTheProduct:(NSString*)phoneNum money:(NSString*)money sucess:(SucessBlock)sucess;
/**
 * 手机直充接口
 */
-(void)phoneFeeQuickCharge:(NSString*)phoneNum money:(NSString*)money type:(PhoneRechargetype)type sucess:(SucessBlock)sucess;
@end
