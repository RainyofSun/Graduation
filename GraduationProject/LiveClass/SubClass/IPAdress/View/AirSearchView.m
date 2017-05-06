//
//  AirSearchView.m
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "AirSearchView.h"
#import <Masonry.h>
#import "WBConfig.h"
#import <SVProgressHUD.h>
#import "VTGeneralTool.h"

@interface AirSearchView ()

//更多城市
@property(nonatomic,strong)UIButton* moreCity;
//查询按钮
@property(nonatomic,strong)UIButton* search;

@end

@implementation AirSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self cityName];
        [self moreCity];
        [self search];
        [self cityNameSearch];
        [self time];
        [self AQI];
        [self quality];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.cityName resignFirstResponder];
}

#pragma mark - 点击方法
-(void)searchAir:(UIButton*)sender{
    [self.cityName resignFirstResponder];
    if ([self.cityName.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"城市不能为空"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        return;
    }
    if ([VTGeneralTool isNumberString:self.cityName.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的城市名字"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(startSeartAirData:)]) {
        [self.delegate startSeartAirData:self.cityName.text];
    }
}

-(void)moreCity:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(searchMoreCity:)]) {
        [self.delegate searchMoreCity:self];
    }
}

-(void)layoutSubviews{
    [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).with.offset(25);
        make.top.equalTo(self.mas_top).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 150, 40));
    }];
    
    [self.moreCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cityName.mas_trailing).with.offset(8);
        make.top.equalTo(self.mas_top).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(90, 40));
    }];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.cityName.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 50, 40));
    }];
    
    [self.cityNameSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 50, 40));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.cityNameSearch.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 50, 40));
    }];
    
    [self.AQI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.time.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 50, 40));
    }];
    
    [self.quality mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.AQI.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 50, 40));
    }];
}

#pragma mark - 懒加载
-(UITextField *)cityName{
    if (!_cityName) {
        _cityName = [[UITextField alloc] init];
        _cityName.placeholder = @"请输入城市的名字";
        _cityName.borderStyle = UITextBorderStyleRoundedRect;
        _cityName.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_cityName];
    }
    return _cityName;
}

-(UIButton *)moreCity{
    if (!_moreCity) {
        _moreCity = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreCity setTitle:@"更多城市" forState:UIControlStateNormal];
        [_moreCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_moreCity setBackgroundColor:[UIColor orangeColor]];
        _moreCity.layer.cornerRadius = 8.0f;
        _moreCity.layer.masksToBounds = YES;
        [_moreCity.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_moreCity addTarget:self action:@selector(moreCity:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreCity];
    }
    return _moreCity;
}

-(UIButton *)search{
    if (!_search) {
        _search = [UIButton buttonWithType:UIButtonTypeCustom];
        [_search setTitle:@"开始搜索" forState:UIControlStateNormal];
        [_search setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _search.backgroundColor = [UIColor orangeColor];
        [_search addTarget:self action:@selector(searchAir:) forControlEvents:UIControlEventTouchUpInside];
        _search.layer.cornerRadius = 8.0;
        _search.layer.masksToBounds = YES;
        [self addSubview:_search];
    }
    return _search;
}

-(UILabel *)AQI{
    if (!_AQI) {
        _AQI = [[UILabel alloc] init];
        _AQI.text = @"AQI指数:";
        [self addSubview:_AQI];
    }
    return _AQI;
}

-(UILabel *)cityNameSearch{
    if (!_cityNameSearch) {
        _cityNameSearch = [[UILabel alloc] init];
        _cityNameSearch.text = @"城  市:";
        [self addSubview:_cityNameSearch];
    }
    return _cityNameSearch;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"查询时间:";
        [self addSubview:_time];
    }
    return _time;
}

-(UILabel *)quality{
    if (!_quality) {
        _quality = [[UILabel alloc] init];
        _quality.text = @"空气质量:";
        [self addSubview:_quality];
    }
    return _quality;
}
@end
