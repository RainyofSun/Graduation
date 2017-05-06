//
//  SearchView.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "SearchView.h"
#import <Masonry.h>
#import "WBConfig.h"
#import "YBPopupMenu.h"
#import <SVProgressHUD.h>
#import "VTGeneralTool.h"

#define TITLES @[@"顺丰快递", @"圆通快递", @"申通快递",@"EMS"]
#define ICONS  @[@"motify",@"delete",@"saoyisao",@"pay"]
@interface SearchView ()<UITextFieldDelegate,YBPopupMenuDelegate>

//输入快递编号
@property(nonatomic,strong)UITextField* num;
//选择要查询的快递公司
@property(nonatomic,strong)UITextField* company;
//点击查询
@property(nonatomic,strong)UIButton* search;

@end

@implementation SearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self num];
        [self company];
        [self search];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.num resignFirstResponder];
    [self.company resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [YBPopupMenu showRelyOnView:textField titles:TITLES icons:ICONS menuWidth:SCREENWIDTH - 30 delegate:self];
}

#pragma mark - YBPopupMenuDelegate
-(void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    self.company.text = TITLES[index];
}

#pragma mark - 点击方法
-(void)search:(UIButton*)sender{
    [self.num resignFirstResponder];
    [self.company resignFirstResponder];
    if (!self.num.text || !self.company.text) {
        [SVProgressHUD showWithStatus:@"请填写完整信息"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    //判断编码是不是纯数字
    if (![VTGeneralTool isPureIntWithStr:self.num.text]) {
        [SVProgressHUD showWithStatus:@"请填写正确的快递单号"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(jumpTheSearchResultView:)]) {
        [self.delegate jumpTheSearchResultView:@{@"num":self.num.text,@"company":self.company.text}];
    }
}

-(void)layoutSubviews{
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 40));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(SCREENHEIGHT/5);
    }];
    
    [self.company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 40));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.num.mas_bottom).with.offset(20);
    }];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 40));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.company.mas_bottom).with.offset(60);
    }];
}

#pragma mark - 懒加载
-(UITextField *)num{
    if (!_num) {
        _num = [[UITextField alloc] init];
        _num.placeholder = @"请输入快递编号";
        _num.borderStyle = UITextBorderStyleRoundedRect;
        _num.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_num];
    }
    return _num;
}

-(UITextField *)company{
    if (!_company) {
        _company = [[UITextField alloc] init];
        _company.placeholder = @"请选择要查询的公司";
        _company.borderStyle = UITextBorderStyleRoundedRect;
        _company.delegate = self;
        [self addSubview:_company];
    }
    return _company;
}

-(UIButton *)search{
    if (!_search) {
        _search = [UIButton buttonWithType:UIButtonTypeCustom];
        [_search setTitle:@"查询" forState:UIControlStateNormal];
        [_search setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _search.backgroundColor = [UIColor orangeColor];
        _search.layer.cornerRadius = 6.0f;
        _search.layer.masksToBounds = YES;
        [_search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_search];
    }
    return _search;
}

@end
