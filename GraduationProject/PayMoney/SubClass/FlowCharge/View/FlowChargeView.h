//
//  FlowChargeView.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlowChargeViewDelegate <NSObject>

/**跳转联系人*/
-(void)obtainTheContactBook:(id)sender;
/**获取充值金额*/
-(void)flowChargeProduct:(NSDictionary*)product;
/**查询手机号归属地*/
-(void)searchPhoneAddressFlow:(NSString *)phoneNum;

@end

@interface FlowChargeView : UIView

@property(nonatomic,weak)id<FlowChargeViewDelegate>delegate;
/**手机归属地*/
@property(nonatomic,strong)UILabel* phoneAddress;
/**用户手机号*/
@property(nonatomic,strong)UITextField* userAccount;

@end
