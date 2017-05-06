//
//  IDCardView.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "IDCardView.h"
#import <Masonry.h>
#import "ACMacros.h"
#import "WBConfig.h"

@interface IDCardView ()<UITextFieldDelegate>

/**输入身份证号*/
@property(nonatomic,strong)UITextField* idCardNum;

@end

@implementation IDCardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self idCardNum];
        [self sex];
        [self birthDay];
        [self address];
        [self num];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //点击键盘return键开始搜索
    if ([self.delegate respondsToSelector:@selector(searchTheIDNum:)]) {
        [self.delegate searchTheIDNum:textField.text];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(searchTheIDNum:)]) {
        [self.delegate searchTheIDNum:self.idCardNum.text];
    }
    [self.idCardNum resignFirstResponder];
}

-(void)layoutSubviews{
    [self.idCardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 40));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(30);
    }];
    
    [self.sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.idCardNum.mas_bottom).with.offset(30);
    }];
    
    [self.birthDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.sex.mas_bottom).with.offset(20);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.birthDay.mas_bottom).with.offset(20);
    }];
    
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.address.mas_bottom).with.offset(20);
    }];
}

#pragma mark - 懒加载
-(UITextField *)idCardNum{
    if (!_idCardNum) {
        _idCardNum = [[UITextField alloc] init];
        _idCardNum.placeholder = @"请输入身份证号";
        _idCardNum.borderStyle = UITextBorderStyleRoundedRect;
        _idCardNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        _idCardNum.delegate = self;
        _idCardNum.keyboardType = UIKeyboardTypeNamePhonePad;
        [self addSubview:_idCardNum];
    }
    return _idCardNum;
}

-(UILabel *)sex{
    if (!_sex) {
        _sex = [[UILabel alloc] init];
        _sex.text = @"性 别:";
        [self addSubview:_sex];
    }
    return _sex;
}

-(UILabel *)birthDay{
    if (!_birthDay) {
        _birthDay = [[UILabel alloc] init];
        _birthDay.text = @"生 日:";
        [self addSubview:_birthDay];
    }
    return _birthDay;
}

-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.text = @"发证地:";
        [self addSubview:_address];
    }
    return _address;
}

-(UILabel *)num{
    if (!_num) {
        _num = [[UILabel alloc] init];
        _num.text = @"证件号:";
        [self addSubview:_num];
    }
    return _num;
}

@end
