//
//  ChargeSucessVC.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "ChargeSucessVC.h"
#import "WBIntroduceFile.h"

@interface ChargeSucessVC ()

//成功的标示
@property(nonatomic,strong)UIImageView* sucessImage;
//套餐名字
@property(nonatomic,strong)UILabel* orderName;
//聚合订单号
@property(nonatomic,strong)UILabel* JH;
//自定义订单号
@property(nonatomic,strong)UILabel* CU;

@end

@implementation ChargeSucessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sucessImage];
    [self orderName];
    [self JH];
    [self CU];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showSuccessWithStatus:@"订单提交成功,请牢记订单号!"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:2];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

#pragma mark - 懒加载
-(UIImageView *)sucessImage{
    if (!_sucessImage) {
        _sucessImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sucess"]];
        [self.view addSubview:_sucessImage];
        [_sucessImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).with.offset(SCREENHEIGHT/5);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _sucessImage;
}

-(UILabel *)orderName{
    if (!_orderName) {
        _orderName = [[UILabel alloc] init];
        _orderName.text = AppendString(@"套餐名称:%@",self.cardname);
        [self.view addSubview:_orderName];
        [_orderName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 40, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.sucessImage.mas_bottom).with.offset(50);
        }];
    }
    return _orderName;
}

-(UILabel *)JH{
    if (!_JH) {
        _JH = [[UILabel alloc] init];
        _JH.text = AppendString(@"聚合订单号:%@", self.JHOrderID);
        [self.view addSubview:_JH];
        [_JH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 40, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.orderName.mas_bottom).with.offset(10);
        }];
    }
    return _JH;
}

-(UILabel *)CU{
    if (!_CU) {
        _CU = [[UILabel alloc] init];
        _CU.text = AppendString(@"自定义订单号:%@", self.CustomOrderID);
        [self.view addSubview:_CU];
        [_CU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 40, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.JH.mas_bottom).with.offset(10);
        }];
    }
    return _CU;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
