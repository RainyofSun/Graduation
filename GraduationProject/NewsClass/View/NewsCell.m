//
//  NewsCell.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//第一种cell只有一张图片

#import "NewsCell.h"
#import "WBBaseImageView.h"
#import <YYText.h>
#import <Masonry.h>
#import "WBConfig.h"
#import "UIView+Extension.h"
#import "UIView+Layer.h"

@interface NewsCell ()

//文章图片
@property(nonatomic,strong)WBBaseImageView* faceImage;
//文章标题
@property(nonatomic,strong)YYLabel* title;
//文章发布时间
@property(nonatomic,strong)YYLabel* date;
//作者名字
@property(nonatomic,strong)YYLabel* authorName;

@end

@implementation NewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViewSeparateLine:CGRectMake(10, 3, SCREENWIDTH - 20, 0.8) color:LIGHTGRAY];
        [self faceImage];
        [self title];
        [self date];
        [self authorName];
    }
    return self;
}

-(void)setModelSource:(NewsModel *)modelSource{
    if (modelSource.thumbnail_pic_s) {
        [self.faceImage setImageWithUrl:modelSource.thumbnail_pic_s];
    }
    
    if (modelSource.title) {
        self.title.text = modelSource.title;
        self.title.textLayout = [NewsModel textLayout:modelSource.title size:CGSizeMake(SCREENWIDTH - 120, 30)];
    }
    
    if (modelSource.author_name) {
        self.authorName.text = modelSource.author_name;
        self.authorName.textLayout = [NewsModel textLayout:modelSource.author_name size:CGSizeMake(80, 20)];
    }
    
    if (modelSource.date) {
        self.date.text = modelSource.date;
        self.date.textLayout = [NewsModel textLayout:modelSource.date size:CGSizeMake(80, 20)];
    }
}

-(void)layoutSubviews{
    
    [self.faceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(10);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 120, 30));
        make.leading.equalTo(self.faceImage.mas_trailing).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(self.contentView.mas_top).with.offset(60);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(120);
    }];
    
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.leading.equalTo(self.date.mas_trailing).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(60);
    }];
}

#pragma mark - 懒加载
-(WBBaseImageView *)faceImage{
    if (!_faceImage) {
        _faceImage = [[WBBaseImageView alloc] init];
        [self.contentView addSubview:_faceImage];
    }
    return _faceImage;
}

-(YYLabel *)title{
    if (!_title) {
        _title = [[YYLabel alloc] init];
        _title.numberOfLines = 0;
        //开启异步绘制
        _title.displaysAsynchronously = YES;
        _title.ignoreCommonProperties = YES;
        _title.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _title.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_title];
    }
    return _title;
}

-(YYLabel *)date{
    if (!_date) {
        _date = [[YYLabel alloc] init];
        //开启异步绘制
        _date.displaysAsynchronously = YES;
        _date.ignoreCommonProperties = YES;
        _date.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _date.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_date];
    }
    return _date;
}


-(YYLabel *)authorName{
    if (!_authorName) {
        _authorName = [[YYLabel alloc] init];
        //开启异步绘制
        _authorName.displaysAsynchronously = YES;
        _authorName.ignoreCommonProperties = YES;
        _authorName.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _authorName.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_authorName];
    }
    return _authorName;
}

@end
