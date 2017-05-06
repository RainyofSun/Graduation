//
//  TVShowListCell.m
//  GraduationProject
//
//  Created by MS on 17/3/12.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "TVShowListCell.h"
#import <Masonry.h>
#import "WBConfig.h"
#import "ACMacros.h"

@interface TVShowListCell ()

@property(nonatomic,strong)UIImageView* tvImage;
//频道名称
@property(nonatomic,strong)UILabel* channelName;
//节目名称
@property(nonatomic,strong)UILabel* showName;
//播出时间
@property(nonatomic,strong)UILabel* showTime;

@end

@implementation TVShowListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self tvImage];
        [self channelName];
        [self showName];
        [self showTime];
    }
    return self;
}

-(void)setModelSource:(TvShowListModel *)modelSource{
    if (modelSource.cName) {
        self.channelName.text = AppendString(@"频道:%@", modelSource.cName);
    }
    if (modelSource.pName) {
        self.showName.text = AppendString(@"节目:%@", modelSource.pName);
    }
    if (modelSource.time) {
        self.showTime.text = AppendString(@"播出时间:%@", modelSource.time);
    }
}

-(void)layoutSubviews{
    [self.tvImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
    }];
    
    [self.channelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 100, 30));
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.leading.equalTo(self.tvImage.mas_trailing).with.offset(5);
    }];
    
    [self.showName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH - 120)/2, 30));
        make.leading.equalTo(self.tvImage.mas_trailing).with.offset(5);
        make.top.equalTo(self.channelName.mas_bottom).with.offset(10);
    }];
    
    [self.showTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH - 120)/2, 30));
        make.leading.equalTo(self.showName.mas_trailing).with.offset(5);
        make.top.equalTo(self.channelName.mas_bottom).with.offset(10);
    }];
}

#pragma mark - 懒加载
-(UIImageView *)tvImage{
    if (!_tvImage) {
        _tvImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tv_show.jpeg"]];
        [self.contentView addSubview:_tvImage];
    }
    return _tvImage;
}

-(UILabel *)channelName{
    if (!_channelName) {
        _channelName = [[UILabel alloc] init];
        [self.contentView addSubview:_channelName];
    }
    return _channelName;
}

-(UILabel *)showName{
    if (!_showName) {
        _showName = [[UILabel alloc] init];
        _showName.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_showName];
    }
    return _showName;
}

-(UILabel *)showTime{
    if (!_showTime) {
        _showTime = [[UILabel alloc] init];
        _showTime.textAlignment = NSTextAlignmentCenter;
        _showTime.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_showTime];
    }
    return _showTime;
}
@end
