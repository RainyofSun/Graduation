//
//  PhoneNumView.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "PhoneNumView.h"
#import "WBConfig.h"
#import <Masonry.h>

@interface PhoneNumView ()<UITextFieldDelegate>
//头像
@property(nonatomic,strong)UIImageView* headImage;
//搜索按钮
@property(nonatomic,strong)UIButton* search;
//手机号
@property(nonatomic,strong)UITextField* phoneNum;

@end

@implementation PhoneNumView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self lazyMethod];
    }
    return self;
}

-(void)lazyMethod{
    [self headImage];
    [self phoneNum];
    [self search];
    [self numAddress];
    [self cardType];
    [self areaNum];
    [self city];
    [self zipCode];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNum resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - search按钮
-(void)search:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(searchThePhoneNum:)]) {
        [self.delegate searchThePhoneNum:self.phoneNum.text];
    }
    [self.phoneNum resignFirstResponder];
}

-(void)layoutSubviews{
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];

    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 100, 30));
        make.leading.equalTo(self.mas_leading).with.offset(15);
        make.top.equalTo(self.headImage.mas_bottom).with.offset(30);
    }];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.leading.equalTo(self.phoneNum.mas_trailing).with.offset(10);
        make.top.equalTo(self.headImage.mas_bottom).with.offset(30);
    }];

    [self.numAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.phoneNum.mas_bottom).with.offset(20);
    }];
    
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.numAddress.mas_bottom).with.offset(20);
    }];

    [self.areaNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.cardType.mas_bottom).with.offset(20);
    }];
   
    [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.areaNum.mas_bottom).with.offset(20);
    }];
    
    [self.zipCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.city.mas_bottom).with.offset(20);
    }];

}

#pragma mark - 懒加载
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithImage:CONTENTFILEIMAGE(@"head")];
        [self addSubview:_headImage];
    }
    return _headImage;
}

-(UIButton *)search{
    if (!_search) {
        _search = [UIButton buttonWithType:UIButtonTypeCustom];
        [_search setTitle:@"查询" forState:UIControlStateNormal];
        [_search setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _search.backgroundColor = [UIColor blueColor];
        [_search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_search];
    }
    return _search;
}

-(UITextField *)phoneNum{
    if (!_phoneNum) {
        _phoneNum = [[UITextField alloc] init];
        _phoneNum.placeholder = @"请输入要查询的电话号码";
        _phoneNum.borderStyle = UITextBorderStyleRoundedRect;
        _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNum.delegate = self;
        [self addSubview:_phoneNum];
    }
    return _phoneNum;
}

-(UILabel *)numAddress{
    if (!_numAddress) {
        _numAddress = [[UILabel alloc] init];
        _numAddress.text = @"号码归属地:";
        [self addSubview:_numAddress];
    }
    return _numAddress;
}

-(UILabel *)cardType{
    if (!_cardType) {
        _cardType = [[UILabel alloc] init];
        _cardType.text = @"运营商/卡类型:";
        [self addSubview:_cardType];
    }
    return _cardType;
}

-(UILabel *)areaNum{
    if (!_areaNum) {
        _areaNum = [[UILabel alloc] init];
        _areaNum.text = @"区 号:";
        [self addSubview:_areaNum];
    }
    return _areaNum;
}

-(UILabel *)city{
    if (!_city) {
        _city = [[UILabel alloc] init];
        _city.text = @"城 市:";
        [self addSubview:_city];
    }
    return _city;
}

-(UILabel *)zipCode{
    if (!_zipCode) {
        _zipCode = [[UILabel alloc] init];
        _zipCode.text = @"邮 编:";
        [self addSubview:_zipCode];
    }
    return _zipCode;
}
@end
