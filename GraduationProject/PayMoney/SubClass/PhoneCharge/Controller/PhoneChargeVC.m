//
//  PhoneChargeVC.m
//  GraduationProject
//
//  Created by MS on 17/3/13.
//  Copyright © 2017年 LR. All rights reserved.
//测试充值  现在参数还缺少openid 然后进行MD5的编码进行充值测试

#import "PhoneChargeVC.h"
#import "RRechargeMoneyView.h"
#import "WBIntroduceFile.h"
#import "FlowChargeVC.h"
#import "PhoneNumRequest.h"
#import "PhoneChargeReqeust.h"
#import <ContactsUI/ContactsUI.h>
#import "ChargeSucessVC.h"

@interface PhoneChargeVC ()<RRechargeMoneyViewDelegate,CNContactPickerDelegate>

@property(nonatomic,strong)RRechargeMoneyView* rechargeView;

@end

@implementation PhoneChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值中心";
    [self rechargeView];
}

#pragma mark - CNContactPickerDelegate
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    CNPhoneNumber* num = nil;
    NSString* string = nil;
    if (contact.phoneNumbers.count > 0) {
        num = contact.phoneNumbers[0].value;
        string = [NSString stringWithFormat:@"%@%@%@",contact.familyName,contact.givenName,[num valueForKey:@"digits"]];
        self.rechargeView.userAccount.text = [num valueForKey:@"digits"];
        [self searchPhoneAddress:[num valueForKey:@"digits"]];
    } else {
        string = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    }
}
#pragma mark - RRechargeMoneyViewDelegate
-(void)obtainProductID:(NSDictionary *)productId{
    if (!productId[@"phone"] || ![VTGeneralTool checkPhoneNumInput:productId[@"phone"]] || [productId[@"phone"] length] != 11) {
        [SVProgressHUD showWithStatus:@"请正确填写手机号码"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    //目前可选：10、20、30、50、100、300
    [[PhoneChargeReqeust shareInstance] phoneFeeQuickCharge:productId[@"phone"] money:productId[@"price"] type:phoneR sucess:^(NSDictionary *dict) {
        if ([dict[@"error_code"] intValue] == 0) {
            ChargeSucessVC* sucess = [[ChargeSucessVC alloc] init];
            sucess.cardname = dict[@"cardname"];
            sucess.JHOrderID = dict[@"sporder_id"];
            sucess.CustomOrderID = dict[@"uorderid"];
            [self presentVc:sucess];
        }
    }];
}

-(void)flowChargeVC:(id)sender{
    [self pushVc:[[FlowChargeVC alloc] init]];
}

#pragma mark - 获取手机号的归属地
-(void)searchPhoneAddress:(NSString *)phoneNum{
    if (!phoneNum || ![VTGeneralTool checkPhoneNumInput:phoneNum] || [phoneNum length] != 11) {
        return;
    }
    [[PhoneNumRequest shareInstance] searchThePhoneNum:phoneNum sucess:^(NSDictionary *dict) {
        [self performOnMainThread:^{
            [self.rechargeView.phoneAddress setText:[NSString stringWithFormat:@"%@%@",dict[@"province"],dict[@"company"]]];
        } wait:NO];
    }];
}

-(void)getTheContactsBook:(id)sender{
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

#pragma - mark 查询商品
-(void)searchProduct:(NSString*)phone money:(NSString*)money{
    [[PhoneChargeReqeust shareInstance] searchTheProduct:phone money:money sucess:^(NSDictionary *dict) {
        
    }];
}

#pragma mark - 懒加载
-(RRechargeMoneyView *)rechargeView{
    if (!_rechargeView) {
        _rechargeView = [[RRechargeMoneyView alloc] init];
        _rechargeView.delegate = self;
        [self.view addSubview:_rechargeView];
        [_rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.equalTo(self.view);
        }];
    }
    return _rechargeView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
