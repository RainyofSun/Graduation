//
//  RRechargeMoneyView.m
//  tag
//
//  Created by MS on 16/10/26.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "RRechargeMoneyView.h"
#import "Masonry.h"
#import "ABButton.h"
#import "UIView+Extension.h"
#import "WBConfig.h"

#define ORANGECOLOR [UIColor colorWithRed:255.0/255 green:165.0/255 blue:97.0/255 alpha:1.0]
#define MARRAGIN 10.0
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define ABButtonMargin 10.0

@interface RRechargeMoneyView ()<UITextFieldDelegate>

/**头像*/
@property(nonatomic,strong)UIButton* head;
/**细线*/
@property(nonatomic,strong)UIView* lineView;
/**更多充值*/
@property(nonatomic,strong)UILabel* moreChargeWay;
/**流量充值*/
@property(nonatomic,strong)UIButton* flowCharge;

@end
@implementation RRechargeMoneyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self userAccount];
        [self head];
        [self phoneAddress];
        [self lineView];
        [self moreChargeWay];
        [self flowCharge];
        [self setupBtn];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userAccount resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchPhoneAddress:)]) {
        [self.delegate searchPhoneAddress:textField.text];
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
    
    [self.moreChargeWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(SCREENHEIGHT/2+30);
        make.leading.equalTo(self.mas_leading).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];
    
    [self.flowCharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreChargeWay.mas_bottom).with.offset(15);
        make.leading.equalTo(self.mas_leading).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];
}

#pragma mark -- 点击方法
-(void)chargePhone:(ABButton*)sender{
    [self.userAccount endEditing:YES];
    for (int i = 0; i < 8; i++) {
        if (sender.tag == i+ 1) {
            sender.selected = YES;
//            ABButton* selectBtn = (ABButton*)[sender viewWithTag:i+1];
            NSString* sepAry = [sender.aboveL.text substringWithRange:NSMakeRange(0, 2)];
            if ([self.delegate respondsToSelector:@selector(obtainProductID:)]) {
                [self.delegate obtainProductID:@{@"phone":self.userAccount.text,@"price":sepAry}];
            }
            continue;
        }
        UIButton* btn = (UIButton*)[self viewWithTag:i + 1];
        btn.selected = NO;
    }
}

-(void)flow:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(flowChargeVC:)]) {
        [self.delegate flowChargeVC:self];
    }
}

-(void)contactPerson:(UIGestureRecognizer*)sender{
    if ([self.delegate respondsToSelector:@selector(getTheContactsBook:)]) {
        [self.delegate getTheContactsBook:self];
    }
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
        [_head addTarget:self action:@selector(contactPerson:) forControlEvents:UIControlEventTouchUpInside];
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

-(UILabel *)moreChargeWay{
    if (!_moreChargeWay) {
        _moreChargeWay = [[UILabel alloc] init];
        _moreChargeWay.text = @"更多充值方式";
        _moreChargeWay.layer.cornerRadius = 6.0f;
        _moreChargeWay.layer.masksToBounds = YES;
        _moreChargeWay.layer.borderColor = RGBCOLOR(164, 164, 164).CGColor;
        _moreChargeWay.layer.borderWidth = 0.5;
        _moreChargeWay.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_moreChargeWay];
    }
    return _moreChargeWay;
}

-(UIButton *)flowCharge{
    if (!_flowCharge) {
        _flowCharge = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flowCharge setTitle:@"流量充值" forState:UIControlStateNormal];
        [_flowCharge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_flowCharge setTitleColor:ORANGECOLOR forState:UIControlStateSelected];
        _flowCharge.layer.cornerRadius = 6.0f;
        _flowCharge.layer.masksToBounds = YES;
        _flowCharge.layer.borderColor = RGBCOLOR(164, 164, 164).CGColor;
        _flowCharge.layer.borderWidth = 0.5;
        [_flowCharge addTarget:self action:@selector(flow:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_flowCharge];
    }
    return _flowCharge;
}

- (void)setupBtn {
    for (int i = 0; i < 8; i++) {
        ABButton *abBtn = [[ABButton alloc] init];
        abBtn.tag = i+1;
        switch (i) {
            case 0:
            {
                [abBtn buttonWithAboveLabelTitle:@"10元" belowLabelTitle:@"备货中"];
                abBtn.enabled = NO;
            }
                break;
            case 1:
            {
                [abBtn buttonWithAboveLabelTitle:@"20元" belowLabelTitle:@"售价:19.91"];
            }
                break;
            case 2:
            {
                [abBtn buttonWithAboveLabelTitle:@"30元" belowLabelTitle:@"售价:29.94"];
            }
                break;
            case 3:
            {
                [abBtn buttonWithAboveLabelTitle:@"50元" belowLabelTitle:@"售价:49.90"];
            }
                break;
                
            case 4:
            {
                [abBtn buttonWithAboveLabelTitle:@"100元" belowLabelTitle:@"售价:99.80"];
            }
                break;
            case 5:
            {
                [abBtn buttonWithAboveLabelTitle:@"200元" belowLabelTitle:@"售价:199.60"];
            }
                break;
            case 6:
            {
                [abBtn buttonWithAboveLabelTitle:@"300元" belowLabelTitle:@"售价:297.60"];
            }
                break;
            case 7:
            {
                [abBtn buttonWithAboveLabelTitle:@"500元" belowLabelTitle:@"售价:499.90"];
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
        [abBtn addTarget:self action:@selector(chargePhone:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
