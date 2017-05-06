//
//  FlowChargeVC.m
//  GraduationProject
//
//  Created by MS on 17/3/13.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "FlowChargeVC.h"
#import "FlowChargeView.h"
#import "WBIntroduceFile.h"
#import <ContactsUI/ContactsUI.h>
#import "PhoneNumRequest.h"
#import "FlowChargeRequest.h"
#import "ChargeSucessVC.h"

@interface FlowChargeVC ()<FlowChargeViewDelegate,CNContactPickerDelegate>

@property(nonatomic,strong)FlowChargeView* flowCharge;

@end

@implementation FlowChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流量充值";
    [self flowCharge];
}

#pragma mark - CNContactPickerDelegate
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    CNPhoneNumber* num = nil;
    NSString* string = nil;
    if (contact.phoneNumbers.count > 0) {
        num = contact.phoneNumbers[0].value;
        string = [NSString stringWithFormat:@"%@%@%@",contact.familyName,contact.givenName,[num valueForKey:@"digits"]];
        self.flowCharge.userAccount.text = [num valueForKey:@"digits"];
        [self searchPhoneAddressFlow:[num valueForKey:@"digits"]];
    } else {
        string = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    }
}

#pragma mark - FlowChargeViewDelegate
-(void)obtainTheContactBook:(id)sender{
    //让用户授予权限
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore* store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"未授权");
            }else{
                NSLog(@"sucess");
                CNContactPickerViewController* picker = [CNContactPickerViewController new];
                picker.delegate = self;
                picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];//只显示手机号
                [self presentVc:picker];
            }
        }];
    }
    if (status == CNAuthorizationStatusAuthorized) {
        //有权限时
        CNContactPickerViewController* picker = [CNContactPickerViewController new];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentVc:picker];
    }else{
        NSLog(@"未开启通讯录权限");
    }
}

-(void)flowChargeProduct:(NSDictionary *)product{
    if (!product[@"phone"] || ![VTGeneralTool checkPhoneNumInput:product[@"phone"]] || [product[@"phone"] length] != 11) {
        [SVProgressHUD showWithStatus:@"请正确填写手机号码"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    [[FlowChargeRequest shareInstance] flowChargeWithPhoneNum:product[@"phone"] orderId:product[@"flowid"] type:PhoneFlowRecharge sucess:^(NSDictionary *dict) {
        if ([dict[@"error_code"] intValue] == 0) {
            ChargeSucessVC* sucess = [[ChargeSucessVC alloc] init];
            sucess.cardname = dict[@"cardname"];
            sucess.JHOrderID = dict[@"sporder_id"];
            sucess.CustomOrderID = dict[@"orderid"];
            [self presentVc:sucess];
        }
    }];
}

#pragma mark - 获取手机号的归属地
-(void)searchPhoneAddressFlow:(NSString *)phoneNum{
    if (!phoneNum || ![VTGeneralTool checkPhoneNumInput:phoneNum] || [phoneNum length] != 11) {
        return;
    }
    [[PhoneNumRequest shareInstance] searchThePhoneNum:phoneNum sucess:^(NSDictionary *dict) {
        [self performOnMainThread:^{
            [self.flowCharge.phoneAddress setText:[NSString stringWithFormat:@"%@%@",dict[@"province"],dict[@"company"]]];
        } wait:NO];
    }];
}

#pragma mark － 懒加载
-(FlowChargeView *)flowCharge{
    if (!_flowCharge) {
        _flowCharge = [[FlowChargeView alloc] init];
        _flowCharge.delegate = self;
        [self.view addSubview:_flowCharge];
        [_flowCharge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.bottom.equalTo(self.view);
        }];
    }
    return _flowCharge;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
