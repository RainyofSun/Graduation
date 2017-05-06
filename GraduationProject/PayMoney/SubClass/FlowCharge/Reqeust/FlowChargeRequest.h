//
//  FlowChargeRequest.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SucessBlock)(NSDictionary*dict);
typedef NS_ENUM(NSUInteger,RechargeType) {
    /**花费充值*/
    phoneFeeRecharge = 1,
    /**流量充值*/
    PhoneFlowRecharge
};

@interface FlowChargeRequest : NSObject

+(instancetype)shareInstance;

/**
 * 按照类型充值
 */
-(void)flowChargeWithPhoneNum:(NSString*)phoneNum orderId:(NSString*)pid type:(RechargeType)type sucess:(SucessBlock)sucess;

@end
