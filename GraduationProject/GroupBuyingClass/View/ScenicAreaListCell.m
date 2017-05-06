//
//  ScenicAreaListCell.m
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "ScenicAreaListCell.h"
#import "ACMacros.h"
#import <Masonry.h>
#import "WBBaseImageView.h"

@interface ScenicAreaListCell ()

//景点图片
@property(nonatomic,strong)WBBaseImageView* spotImg;
//景点名字
@property(nonatomic,strong)UILabel* title;
//景点等级
@property(nonatomic,strong)UILabel* grade;
//门票
@property(nonatomic,strong)UILabel* price;
//评论
@property(nonatomic,strong)UILabel* comment;
//地址
@property(nonatomic,strong)UILabel* address;

@end

@implementation ScenicAreaListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self spotImg];
        [self title];
        [self grade];
        [self price];
        [self comment];
        [self address];
    }
    return self;
}

-(void)setDataSource:(ScenicAresListModel *)dataSource{
    if (dataSource.imgurl) {
        [self.spotImg setImageWithUrl:dataSource.imgurl];
    }
    
    if (dataSource.title) {
        self.title.text = dataSource.title;
    }
    
    if (dataSource.grade) {
        if ([dataSource.grade isEqualToString:@""]) {
            self.grade.text = @"";
        }else{
            self.grade.attributedText = [[NSMutableAttributedString alloc] initWithString:AppendString(@"等级: %@", dataSource.grade) attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
        }
    }else{
        self.grade.text = @"";
    }
    
    if (dataSource.price_min) {
        self.price.text = AppendString(@"门票价格: %@", dataSource.price_min);
    }
    
    if (dataSource.comm_cnt) {
        self.comment.text = AppendString(@"评价: %@", dataSource.comm_cnt);
    }
    
    if (dataSource.address) {
        self.address.text = dataSource.address;
    }
}

-(void)layoutSubviews{
    [self.spotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(3);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width/2, 30));
        make.leading.equalTo(self.spotImg.mas_trailing).with.offset(3);
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
    }];
    
    [self.grade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 30));
        make.leading.equalTo(self.title.mas_trailing).with.offset(3);
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width/3, 30));
        make.leading.equalTo(self.spotImg.mas_trailing).with.offset(3);
        make.top.equalTo(self.title.mas_bottom).with.offset(3);
    }];
    
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width/3, 30));
        make.leading.equalTo(self.price.mas_trailing).with.offset(3);
        make.top.equalTo(self.grade.mas_bottom).with.offset(3);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 100, 30));
        make.leading.equalTo(self.spotImg.mas_trailing).with.offset(3);
        make.top.equalTo(self.price.mas_bottom).with.offset(3);
    }];
}

#pragma mark - 懒加载
-(WBBaseImageView *)spotImg{
    if (!_spotImg) {
        _spotImg = [[WBBaseImageView alloc] init];
        _spotImg.layer.cornerRadius = 5.0f;
        _spotImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_spotImg];
    }
    return _spotImg;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
    }
    return _title;
}

-(UILabel *)grade{
    if (!_grade) {
        _grade = [[UILabel alloc] init];
        [self.contentView addSubview:_grade];
    }
    return _grade;
}

-(UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
    }
    return _price;
}

-(UILabel *)comment{
    if (!_comment) {
        _comment = [[UILabel alloc] init];
        [self.contentView addSubview:_comment];
    }
    return _comment;
}

-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_address];
    }
    return _address;
}
@end
