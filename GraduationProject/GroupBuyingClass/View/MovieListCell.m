//
//  MovieListCell.m
//  GraduationProject
//
//  Created by MS on 17/3/29.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MovieListCell.h"
#import <Masonry.h>
#import "ACMacros.h"

@interface MovieListCell ()

//图片
@property(nonatomic,strong)UIImageView* moviePic;
//影院名称
@property(nonatomic,strong)UILabel* movieTitle;
//影院地址
@property(nonatomic,strong)UILabel* address;

@end

@implementation MovieListCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self moviePic];
        [self movieTitle];
        [self address];
    }
    return self;
}

-(void)setDataSource:(MovieListModel *)dataSource{
    if (dataSource.cinemaName) {
        self.movieTitle.text = dataSource.cinemaName;
    }
    
    if (dataSource.address) {
        self.address.text = dataSource.address;
    }
}

-(void)layoutSubviews{
    [self.moviePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-50);
    }];
    
    [self.movieTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.bounds.size.width - 6, 20));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.moviePic.mas_bottom).with.offset(3);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.bounds.size.width - 6, 20));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.movieTitle.mas_bottom).with.offset(3);
    }];
}

#pragma mark - 懒加载
-(UIImageView *)moviePic{
    if (!_moviePic) {
        _moviePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie.jpg"]];
        _moviePic.layer.cornerRadius = 5.0f;
        _moviePic.layer.masksToBounds = YES;
        [self.contentView addSubview:_moviePic];
    }
    return _moviePic;
}

-(UILabel *)movieTitle{
    if (!_movieTitle) {
        _movieTitle = [[UILabel alloc] init];
        _movieTitle.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_movieTitle];
    }
    return _movieTitle;
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
