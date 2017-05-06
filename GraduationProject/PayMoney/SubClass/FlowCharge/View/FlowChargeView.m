//
//  FlowChargeView.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "FlowChargeView.h"
#import "Masonry.h"
#import "ABButton.h"
#import "UIView+Extension.h"
#import "WBConfig.h"

#define ORANGECOLOR [UIColor colorWithRed:255.0/255 green:165.0/255 blue:97.0/255 alpha:1.0]
#define MARRAGIN 10.0
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define ABButtonMargin 10.0

@interface FlowChargeView ()<UITextFieldDelegate>

/**头像*/
@property(nonatomic,strong)UIButton* head;
/**细线*/
@property(nonatomic,strong)UIView* lineView;
/**充值ID*/
@property(nonatomic,strong)NSArray* flowID;

@end

@implementation FlowChargeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self userAccount];
        [self head];
        [self phoneAddress];
        [self lineView];
        [self setupBtn];
        self.flowID = @[@"8",@"9",@"32",@"10",@"11",@"12",@"28"];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userAccount resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchPhoneAddressFlow:)]) {
        [self.delegate searchPhoneAddressFlow:textField.text];
    }
}

#pragma mark - 点击方法
-(void)flowContactPerson:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(obtainTheContactBook:)]) {
        [self.delegate obtainTheContactBook:self];
    }
}

-(void)chargeFlow:(ABButton*)sender{
    [self.userAccount endEditing:YES];
    for (int i = 0; i < 8; i++) {
        if (sender.tag == i+ 1) {
            sender.selected = YES;
            if ([self.delegate respondsToSelector:@selector(flowChargeProduct:)]) {
                [self.delegate flowChargeProduct:@{@"phone":self.userAccount.text,
                                                   @"flowid":self.flowID[i]}];
            }
            continue;
        }
        UIButton* btn = (UIButton*)[self viewWithTag:i + 1];
        btn.selected = NO;
    }
}

-(void)layoutSubviews{
    [self.userAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-100, 50));
        make.leading.equalTo(self.mas_leading).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(50);
    }];
    
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.mas_equalTo(self.userAccount.mas_centerY);
        make.leading.equalTo(self.userAccount.mas_trailing).with.offset(10);
    }];
    
    [self.phoneAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 20));
        make.top.equalTo(self.userAccount.mas_bottom).with.offset(3);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 1));
        make.top.equalTo(self.phoneAddress.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma mark - 懒加载
-(UITextField *)userAccount{
    if (!_userAccount) {
        _userAccount = [[UITextField alloc] init];
        _userAccount.delegate = self;
        _userAccount.placeholder = @"请输入充值手机号";
        _userAccount.keyboardType = UIKeyboardTypePhonePad;
        _userAccount.textColor = [UIColor blackColor];
        _userAccount.font = [UIFont systemFontOfSize:26];
        [self addSubview:_userAccount];
    }
    return _userAccount;
}

-(UIButton *)head{
    if (!_head) {
        _head = [[UIButton alloc] init];
        [_head setBackgroundImage:[UIImage imageNamed:@"Contacts"] forState:UIControlStateNormal];
        [_head addTarget:self action:@selector(flowContactPerson:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_head];
    }
    return _head;
}

-(UILabel *)phoneAddress{
    if (!_phoneAddress) {
        _phoneAddress = [[UILabel alloc] init];
        _phoneAddress.textColor = RGBCOLOR(177, 179, 182);
        _phoneAddress.font = [UIFont systemFontOfSize:15];
        [self addSubview:_phoneAddress];
    }
    return _phoneAddress;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (void)setupBtn {
    for (int i = 0; i < 7; i++) {
        ABButton *abBtn = [[ABButton alloc] init];
        abBtn.tag = i+1;
        switch (i) {
            case 0:
            {
                [abBtn buttonWithAboveLabelTitle:@"10M" belowLabelTitle:@"售价:1.860"];
            }
                break;
            case 1:
            {
                [abBtn buttonWithAboveLabelTitle:@"30M" belowLabelTitle:@"售价:4.650"];
            }
                break;
            case 2:
            {
                [abBtn buttonWithAboveLabelTitle:@"50M" belowLabelTitle:@"售价:6.510"];
            }
                break;
            case 3:
            {
                [abBtn buttonWithAboveLabelTitle:@"100M" belowLabelTitle:@"售价:9.300"];
            }
                break;
                
            case 4:
            {
                [abBtn buttonWithAboveLabelTitle:@"200M" belowLabelTitle:@"售价:13.950"];
            }
                break;
            case 5:
            {
                [abBtn buttonWithAboveLabelTitle:@"500M" belowLabelTitle:@"售价:27.900"];
            }
                break;
            case 6:
            {
                [abBtn buttonWithAboveLabelTitle:@"1G" belowLabelTitle:@"售价:46.500"];
            }
                break;
            default:
                break;
        }
        
        int col = i % 3;
        abBtn.x = col * (abBtn.width + ABButtonMargin)+20;
        int row = i / 3;
        abBtn.y = row * (abBtn.height + ABButtonMargin)+180;
        [self addSubview:abBtn];
        [abBtn addTarget:self action:@selector(chargeFlow:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
