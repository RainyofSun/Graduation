//
//  PayFeeVC.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "PayFeeVC.h"
#import "WBIntroduceFile.h"
#import "FlowChargeVC.h"
#import "PhoneChargeVC.h"

@interface PayFeeVC ()

//选择充值项目
@property(nonatomic,strong)UILabel* choose;
//话费
@property(nonatomic,strong)UIButton* telephoneFare;
@property(nonatomic,strong)UIImageView* telephoneimg;

//流量
@property(nonatomic,strong)UIButton* flow;
@property(nonatomic,strong)UIImageView* flowImg;

@end

@implementation PayFeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self choose];
    [self telephoneFare];
    [self telephoneimg];
    [self flow];
    [self flowImg];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self rdv_tabBarController].navigationItem.rightBarButtonItem = nil;
}

#pragma mark - 点击方法
-(void)telephone:(UIButton*)sender{
    [self pushVc:[[PhoneChargeVC alloc] init]];
}

-(void)flow:(UIButton*)sender{
    [self pushVc:[[FlowChargeVC alloc] init]];
}

#pragma mark - 懒加载
-(UILabel *)choose{
    if (!_choose) {
        _choose = [[UILabel alloc] init];
        _choose.text = @"请选择充值项目";
        _choose.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_choose];
        [_choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).with.offset(SCREENHEIGHT/5);
        }];
    }
    return _choose;
}

-(UIButton *)telephoneFare{
    if (!_telephoneFare) {
        _telephoneFare = [[UIButton alloc] init];
        [_telephoneFare setTitle:@"话费充值" forState:UIControlStateNormal];
        [_telephoneFare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_telephoneFare addTarget:self action:@selector(telephone:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_telephoneFare];
        [_telephoneFare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/4, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.choose.mas_bottom).with.offset(30);
        }];
    }
    return _telephoneFare;
}

-(UIImageView *)telephoneimg{
    if (!_telephoneimg) {
        _telephoneimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_f.jpg"]];
        [self.view addSubview:_telephoneimg];
        [_telephoneimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.telephoneFare.mas_centerY);
            make.trailing.equalTo(self.telephoneFare.mas_leading).with.offset(-5);
        }];
    }
    return _telephoneimg;
}

-(UIButton *)flow{
    if (!_flow) {
        _flow = [[UIButton alloc] init];
        [_flow setTitle:@"流量充值" forState:UIControlStateNormal];
        [_flow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_flow addTarget:self action:@selector(flow:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_flow];
        [_flow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/4, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.telephoneFare.mas_bottom).with.offset(40);
        }];
    }
    return _flow;
}

-(UIImageView *)flowImg{
    if (!_flowImg) {
        _flowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flow_c.jpg"]];
        [self.view addSubview:_flowImg];
        [_flowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.flow.mas_centerY);
            make.trailing.equalTo(self.flow.mas_leading).with.offset(-5);
        }];
    }
    return _flowImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
