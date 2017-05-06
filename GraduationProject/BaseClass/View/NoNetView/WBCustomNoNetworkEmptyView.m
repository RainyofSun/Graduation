//
//  WBCustomNoNetworkEmptyView.m
//  BXYJWB
//
//  Created by MS on 17/1/17.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBCustomNoNetworkEmptyView.h"
#import "WBConfig.h"
#import "UIView+Frame.h"

@interface WBCustomNoNetworkEmptyView ()

@property(nonatomic,weak)UIImageView* topTipImageView;
@property(nonatomic,weak)UIButton* retryButton;

@end

@implementation WBCustomNoNetworkEmptyView

-(UIImageView *)topTipImageView{
    if (!_topTipImageView) {
        UIImageView* img = [[UIImageView alloc] init];
        [self addSubview:img];
        _topTipImageView = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = WHITE;
    }
    return _topTipImageView;
}

-(UIButton *)retryButton{
    if (!_retryButton) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _retryButton = btn;
        btn.backgroundColor = ORANGE;
        [btn setTitle:@"马上重试" forState:UIControlStateNormal];
        [btn setTitleColor:WHITE forState:UIControlStateNormal];
        btn.titleLabel.font = SETFONTSIZE(15);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenDisabled = NO;
        btn.adjustsImageWhenHighlighted = NO;
    }
    return _retryButton;
}

-(void)btnClick:(UIButton*)sender{
    if (self.customNoNetworkEmptyViewDidClickRetryHandle) {
        self.customNoNetworkEmptyViewDidClickRetryHandle(self);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat topTipW = 100;
    CGFloat topTipX = SCREENWIDTH/2.0 - topTipW /2.0;
    CGFloat topTipY = 150;
    CGFloat topTipH = 100;
    self.topTipImageView.frame = CGRectMake(topTipX, topTipY, topTipW, topTipH);
    
    CGFloat retryX = topTipX + 20;
    CGFloat retryY = self.topTipImageView.bottom + 15;
    CGFloat retryW = 60;
    CGFloat retryH = 25;
    self.retryButton.frame = CGRectMake(retryX, retryY, retryW, retryH);
}

@end
