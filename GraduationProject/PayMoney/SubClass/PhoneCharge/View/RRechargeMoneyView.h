//
//  RRechargeMoneyView.h
//  tag
//
//  Created by MS on 16/10/26.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RRechargeMoneyViewDelegate <NSObject>
/**代理传值productID*/
-(void)obtainProductID:(NSDictionary*)productId;
/**跳转到流量充值*/
-(void)flowChargeVC:(id)sender;
/**查询归属地*/
-(void)searchPhoneAddress:(NSString*)phoneNum;
/**跳转到电话薄*/
-(void)getTheContactsBook:(id)sender;

@end

@interface RRechargeMoneyView : UIView
@property(nonatomic,weak)id<RRechargeMoneyViewDelegate> delegate;
/**手机归属地*/
@property(nonatomic,strong)UILabel* phoneAddress;
/**用户手机号*/
@property(nonatomic,strong)UITextField* userAccount;
@end
