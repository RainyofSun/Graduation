//
//  GroupBuyinyRecommondCell.m
//  GraduationProject
//
//  Created by MS on 17/3/23.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "GroupBuyinyRecommondCell.h"
#import "WBBaseImageView.h"
#import <Masonry.h>
#import "WBConfig.h"
#import "XHStarRateView.h"
#import "ACMacros.h"
#import "UIView+Layer.h"

@interface GroupBuyinyRecommondCell ()

//图片
@property(nonatomic,strong)WBBaseImageView* photos;
//店名
@property(nonatomic,strong)UILabel* name;
//评级
@property(nonatomic,strong)XHStarRateView* stars;
//总评论
@property(nonatomic,strong)UILabel* totalCommen;
//标签
@property(nonatomic,strong)UILabel* tags;
//人均消费
@property(nonatomic,strong)UILabel* aver_fee;
//位置
@property(nonatomic,strong)UILabel* address;

@end

@implementation GroupBuyinyRecommondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViewSeparateLine:CGRectMake(10, 3, SCREENWIDTH - 20, 0.8) color:LIGHTGRAY];
        [self photos];
        [self name];
        [self stars];
        [self totalCommen];
        [self tags];
        [self aver_fee];
        [self address];
    }
    return self;
}

-(void)setModelSource:(GroupBuyingModel *)modelSource{
    if (modelSource.photos) {
        [self.photos setImageWithUrl:modelSource.photos];
    }
    
    if (modelSource.name) {
        self.name.text = modelSource.name;
    }
    
    if (modelSource.stars) {
        self.stars.currentScore = modelSource.stars;
    }
    
    if (modelSource.all_remarks) {
        self.totalCommen.text = AppendString(@"评论: %d", modelSource.all_remarks);
    }else{
        self.totalCommen.text = @"暂无评论";
    }
    
    if (modelSource.tags) {
        self.tags.text = modelSource.tags;
    }else{
        self.tags.text = @"暂无评价";
    }
    
    if (modelSource.avg_price) {
        self.aver_fee.text = AppendString(@"人均消费: %@", modelSource.avg_price);
    }
    
    if (modelSource.address) {
        self.address.text = modelSource.address;
    }
}

-(void)layoutSubviews{
    [self.photos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3*2, 30));
        make.leading.equalTo(self.photos.mas_trailing).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
    }];
    
    [self.stars mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.left.equalTo(self.name);
        make.top.equalTo(self.name.mas_bottom).with.offset(3);
    }];
    
    [self.totalCommen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20));
        make.centerY.equalTo(self.stars);
        make.leading.equalTo(self.stars.mas_trailing).with.offset(3);
    }];
    
    [self.tags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/2, 30));
        make.left.equalTo(self.name);
        make.top.equalTo(self.stars.mas_bottom).with.offset(3);
    }];
    
    [self.aver_fee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.left.equalTo(self.name);
        make.top.equalTo(self.tags.mas_bottom).with.offset(3);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/2, 30));
        make.centerY.equalTo(self.aver_fee);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-10);
    }];
}

#pragma mark - 懒加载
-(WBBaseImageView *)photos{
    if (!_photos) {
        _photos = [[WBBaseImageView alloc] init];
        _photos.layer.cornerRadius = 3.0f;
        _photos.layer.masksToBounds = YES;
        [self.contentView addSubview:_photos];
    }
    return _photos;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        [self.contentView addSubview:_name];
    }
    return _name;
}

-(XHStarRateView *)stars{
    if (!_stars) {
        _stars = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _stars.rateStyle = IncompleteStar;
        [self.contentView addSubview:_stars];
    }
    return _stars;
}

-(UILabel *)totalCommen{
    if (!_totalCommen) {
        _totalCommen = [[UILabel alloc] init];
        _totalCommen.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_totalCommen];
    }
    return _totalCommen;
}

-(UILabel *)tags{
    if (!_tags) {
        _tags = [[UILabel alloc] init];
        _tags.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_tags];
    }
    return _tags;
}

-(UILabel *)aver_fee{
    if (!_aver_fee) {
        _aver_fee = [[UILabel alloc] init];
        _aver_fee.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_aver_fee];
    }
    return _aver_fee;
}

-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_address];
    }
    return _address;
}

@end
