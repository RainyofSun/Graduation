//
//  MovieHallCell.m
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MovieHallCell.h"
#import "ACMacros.h"
#import <Masonry.h>

@interface MovieHallCell ()

//演播厅号
@property(nonatomic,strong)UILabel* hallNum;
//票价
@property(nonatomic,strong)UILabel* ticketPrice;
//开演时间
@property(nonatomic,strong)UILabel* time;
//立即预定
@property(nonatomic,strong)UIButton* customTicket;
//订票页面
@property(nonatomic,copy)NSString* ticketUrl;

@end

@implementation MovieHallCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self hallNum];
        [self ticketPrice];
        [self time];
        [self customTicket];
    }
    return self;
}

-(void)customTicket:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(buyTickets:)]) {
        [self.delegate buyTickets:self.ticketUrl];
    }
}

-(void)setHallModel:(MovieHallModel *)hallModel{
    if (hallModel.hall) {
        self.hallNum.text = hallModel.hall;
    }
    
    if (hallModel.price) {
        self.ticketPrice.text = hallModel.price;
    }
    
    if (hallModel.time) {
        self.time.text = hallModel.time;
    }
    
    if (hallModel.ticket_url) {
        self.ticketUrl = hallModel.ticket_url;
    }
}

-(void)layoutSubviews{
    [self.hallNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.ticketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.hallNum.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.ticketPrice.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.customTicket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.time.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

#pragma mark - 懒加载
-(UILabel *)hallNum{
    if (!_hallNum) {
        _hallNum = [[UILabel alloc] init];
        _hallNum.font = [UIFont systemFontOfSize:14];
        _hallNum.textAlignment = NSTextAlignmentCenter;
        _hallNum.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_hallNum];
    }
    return _hallNum;
}

-(UILabel *)ticketPrice{
    if (!_ticketPrice) {
        _ticketPrice = [[UILabel alloc] init];
        _ticketPrice.font = [UIFont systemFontOfSize:14];
        _ticketPrice.textAlignment = NSTextAlignmentCenter;
        _ticketPrice.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_ticketPrice];
    }
    return _ticketPrice;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:14];
        _time.textAlignment = NSTextAlignmentCenter;
        _time.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_time];
    }
    return _time;
}

-(UIButton *)customTicket{
    if (!_customTicket) {
        _customTicket = [[UIButton alloc] init];
        [_customTicket setTitle:@"立即预定" forState:UIControlStateNormal];
        [_customTicket setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _customTicket.backgroundColor = [UIColor orangeColor];
        _customTicket.titleLabel.font = [UIFont systemFontOfSize:13];
        _customTicket.layer.cornerRadius = 4.0f;
        _customTicket.layer.masksToBounds = YES;
        [_customTicket addTarget:self action:@selector(customTicket:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_customTicket];
    }
    return _customTicket;
}

@end
