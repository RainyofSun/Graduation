//
//  PhoneNumVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//接口受限再作考虑

#import "PhoneNumVC.h"
#import "WBIntroduceFile.h"
#import "PhoneNumView.h"
#import "PhoneNumRequest.h"

@interface PhoneNumVC ()<PhoneNumViewDelegate>

@property(nonatomic,strong)PhoneNumView* phoneView;

@end

@implementation PhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机归属地";
    [self phoneView];
}

#pragma mark - PhoneNumViewDelegate
-(void)searchThePhoneNum:(NSString *)phoneNum{
    if (phoneNum.length != 11 || ![VTGeneralTool isPureIntWithStr:phoneNum]) {
        [SVProgressHUD showWithStatus:@"请输入正确的电话号码"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    
    if ([VTGeneralTool checkPhoneNumInput:phoneNum]) {
        [self searchPhoneAddress:phoneNum];
    }
}

#pragma mark - 开始搜索
-(void)searchPhoneAddress:(NSString*)phoneNum{
    [SVProgressHUD showWithStatus:@"正在查询..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[PhoneNumRequest shareInstance] searchThePhoneNum:phoneNum sucess:^(NSDictionary *dict) {
        [SVProgressHUD dismiss];
       [self performOnMainThread:^{
           [self.phoneView.numAddress setText:AppendString(@"号码归属地:    %@", dict[@"province"])];
           [self.phoneView.cardType setText:AppendString(@"运营商/卡类型:    %@", dict[@"company"])];
           [self.phoneView.areaNum setText:AppendString(@"区号:    %@", dict[@"areacode"])];
           [self.phoneView.city setText:AppendString(@"城市:    %@", dict[@"city"])];
           [self.phoneView.zipCode setText:AppendString(@"邮编:    %@", dict[@"zip"])];
       } wait:NO];
    }];
}
#pragma mark - 懒加载
-(PhoneNumView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[PhoneNumView alloc] initWithFrame:self.view.bounds];
        _phoneView.delegate = self;
        [self.view addSubview:_phoneView];
    }
    return _phoneView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
