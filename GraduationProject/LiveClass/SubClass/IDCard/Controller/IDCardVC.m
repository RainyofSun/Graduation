//
//  IDCardVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "IDCardVC.h"
#import "WBIntroduceFile.h"
#import "IDCardView.h"
#import "IDCardReqeust.h"

@interface IDCardVC ()<IDCardViewDelegate>

@property(nonatomic,strong)IDCardView* cardNumView;

@end

@implementation IDCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证查询";
    [self cardNumView];
}

#pragma mark - IDCardViewDelegate
-(void)searchTheIDNum:(NSString *)idNum{
    if (idNum.length != 18) {
        [SVProgressHUD showWithStatus:@"请输入正确的身份证号"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    [self searchIdNumWithString:idNum];
}

#pragma mark - 查询身份证
-(void)searchIdNumWithString:(NSString*)num{
    [SVProgressHUD showWithStatus:@"正在查询..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[IDCardReqeust shareInstance] searchIdCardNum:num sucess:^(NSDictionary *dict) {
        [SVProgressHUD dismiss];
        [self performOnMainThread:^{
            [self.cardNumView.sex setText:AppendString(@"性 别:    %@", dict[@"sex"])];
            [self.cardNumView.birthDay setText:AppendString(@"生 日:    %@", dict[@"birthday"])];
            [self.cardNumView.address setText:AppendString(@"发证地:    %@", dict[@"area"])];
            [self.cardNumView.num setText:AppendString(@"证件号:    %@", num)];
        } wait:NO];
    }];
}

#pragma mark - 懒加载
-(IDCardView *)cardNumView{
    if (!_cardNumView) {
        _cardNumView = [[IDCardView alloc] initWithFrame:self.view.bounds];
        _cardNumView.delegate = self;
        [self.view addSubview:_cardNumView];
    }
    return _cardNumView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
