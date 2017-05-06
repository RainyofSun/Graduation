//
//  MovieDetailHeadView.m
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MovieDetailHeadView.h"
#import <Masonry.h>
#import "ACMacros.h"
#import "UIView+Tap.h"

@implementation MovieDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self movieTitle];
        [self moviePhone];
        [self address];
        [self movieTransport];
    }
    return self;
}

-(void)phone:(UIGestureRecognizer*)sender{
    [self makeAcall:self.moviePhone.text];
}

-(void)makeAcall:(NSString*)num{
    UIWebView * callWebview = [[UIWebView alloc]init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",num]]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

-(void)layoutSubviews{
    
    [self.movieTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 20, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(3);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.movieTitle);
        make.top.equalTo(self.movieTitle.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width/2, 25));
    }];
    
    [self.moviePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.address.mas_trailing).with.offset(8);
        make.top.equalTo(self.address);
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width/3, 25));
    }];
    
    [self.movieTransport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.address.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 20, 40));
    }];
}

#pragma mark - 懒加载
-(UILabel *)movieTitle{
    if (!_movieTitle) {
        _movieTitle = [[UILabel alloc] init];
        _movieTitle.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_movieTitle];
    }
    return _movieTitle;
}

-(UILabel *)moviePhone{
    if (!_moviePhone) {
        _moviePhone = [[UILabel alloc] init];
        _moviePhone.userInteractionEnabled = YES;
        [_moviePhone setTapTarget:self action:@selector(phone:)];
        _moviePhone.font = [UIFont systemFontOfSize:14];
        [self addSubview:_moviePhone];
    }
    return _moviePhone;
}

-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.font = [UIFont systemFontOfSize:15];
        [self addSubview:_address];
    }
    return _address;
}

-(YYLabel *)movieTransport{
    if (!_movieTransport) {
        _movieTransport = [[YYLabel alloc] init];
        _movieTransport.numberOfLines = 0;
        _movieTransport.ignoreCommonProperties = YES;
        _movieTransport.displaysAsynchronously = YES;
        [self addSubview:_movieTransport];
    }
    return _movieTransport;
}
@end
