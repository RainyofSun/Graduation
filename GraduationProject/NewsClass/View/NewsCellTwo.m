//
//  NewsCellTwo.m
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//第二种cell-->只有2张图片

#import "NewsCellTwo.h"
#import <YYText.h>
#import "WBBaseImageView.h"
#import <Masonry.h>
#import "WBConfig.h"
#import "UIView+Layer.h"

@interface NewsCellTwo ()

//文章图片
@property(nonatomic,strong)WBBaseImageView* faceImage;
@property(nonatomic,strong)WBBaseImageView* faceImage1;
//文章标题
@property(nonatomic,strong)YYLabel* title;
//文章发布时间
@property(nonatomic,strong)YYLabel* date;
//作者名字
@property(nonatomic,strong)YYLabel* authorName;

@end

@implementation NewsCellTwo

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViewSeparateLine:CGRectMake(10, 3, SCREENWIDTH - 20, 0.8) color:LIGHTGRAY];
        [self title];
        [self date];
        [self authorName];
        [self faceImage];
        [self faceImage1];
    }
    return self;
}

-(void)setModelSource:(NewsModel *)modelSource{
    if (modelSource.thumbnail_pic_s) {
        [self.faceImage setImageWithUrl:modelSource.thumbnail_pic_s];
    }
    
    if (modelSource.thumbnail_pic_s02) {
        [self.faceImage1 setImageWithUrl:modelSource.thumbnail_pic_s02];
    }
    
    if (modelSource.title) {
        self.title.text = modelSource.title;
        self.title.textLayout = [NewsModel textLayout:modelSource.title size:CGSizeMake(SCREENWIDTH - 30, 40)];
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
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 20, 30));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(10);
        make.top.equalTo(self.title.mas_bottom).with.offset(3);
    }];
    
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.leading.equalTo(self.date.mas_trailing).with.offset(10);
        make.top.equalTo(self.title.mas_bottom).with.offset(3);
    }];
    
    [self.faceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(15);
        make.top.equalTo(self.title.mas_bottom).with.offset(30);
    }];
    
    [self.faceImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.leading.equalTo(self.faceImage.mas_trailing).with.offset(10);
        make.top.equalTo(self.title.mas_bottom).with.offset(30);
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

-(WBBaseImageView *)faceImage1{
    if (!_faceImage1) {
        _faceImage1 = [[WBBaseImageView alloc] init];
        [self.contentView addSubview:_faceImage1];
    }
    return _faceImage1;
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
        _date.numberOfLines = 0;
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
        _authorName.numberOfLines = 0;
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
