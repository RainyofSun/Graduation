//
//  CurrencyCell.m
//  GraduationProject
//
//  Created by MS on 17/3/11.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "CurrencyCell.h"
#import <Masonry.h>
#import "WBConfig.h"

@interface CurrencyCell ()

//城市
@property(nonatomic,strong)UILabel* city;
//93#
@property(nonatomic,strong)UILabel* oil1;
//97#
@property(nonatomic,strong)UILabel* oil2;
//90#
@property(nonatomic,strong)UILabel* oil3;
//0#
@property(nonatomic,strong)UILabel* oil4;

@end

@implementation CurrencyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self lazyMethods];
    }
    return self;
}

#pragma mark - lazyMethods
-(void)lazyMethods{
    [self city];
    [self oil1];
    [self oil2];
    [self oil3];
    [self oil4];
}

-(void)setModelSource:(OilQueryModel *)modelSource{
    if (modelSource.city) {
        self.city.text = [NSString stringWithFormat:@"城市:%@",modelSource.city];
    }
    
    if (modelSource.b90) {
        self.oil3.text = [NSString stringWithFormat:@"90#:%@",modelSource.b90];
    }
    
    if (modelSource.b0) {
        self.oil4.text = [NSString stringWithFormat:@"0#:%@",modelSource.b0];
    }
    
    if (modelSource.b93) {
        self.oil1.text = [NSString stringWithFormat:@"93#:%@",modelSource.b93];
    }
    
    if (modelSource.b97) {
        self.oil2.text = [NSString stringWithFormat:@"97#:%@",modelSource.b97];
    }
}

-(void)layoutSubviews{
    [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/2, 20));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(SCREENWIDTH/8);
        make.top.equalTo(self.contentView.mas_top).with.offset(8);
    }];
    
    [self.oil1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3+20, 20));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(SCREENWIDTH/8);
        make.top.equalTo(self.city.mas_bottom).with.offset(3);
    }];
    
    [self.oil2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3+20, 20));
        make.leading.equalTo(self.oil1.mas_trailing).with.offset(SCREENWIDTH/8);
        make.top.equalTo(self.city.mas_bottom).with.offset(3);
    }];
    
    [self.oil3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3+20, 20));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(SCREENWIDTH/8);
        make.top.equalTo(self.oil1.mas_bottom).with.offset(3);
    }];
    
    [self.oil4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3+20, 20));
        make.leading.equalTo(self.oil3.mas_trailing).with.offset(SCREENWIDTH/8);
        make.top.equalTo(self.oil2.mas_bottom).with.offset(3);
    }];
}

#pragma mark - 懒加载
-(UILabel *)city{
    if (!_city) {
        _city = [[UILabel alloc] init];
        [self.contentView addSubview:_city];
    }
    return _city;
}

-(UILabel *)oil1{
    if (!_oil1) {
        _oil1 = [[UILabel alloc] init];
        [self.contentView addSubview:_oil1];
    }
    return _oil1;
}

-(UILabel *)oil2{
    if (!_oil2) {
        _oil2 = [[UILabel alloc] init];
        [self.contentView addSubview:_oil2];
    }
    return _oil2;
}

-(UILabel *)oil3{
    if (!_oil3) {
        _oil3 = [[UILabel alloc] init];
        [self.contentView addSubview:_oil3];
    }
    return _oil3;
}

-(UILabel *)oil4{
    if (!_oil4) {
        _oil4 = [[UILabel alloc] init];
        [self.contentView addSubview:_oil4];
    }
    return _oil4;
}

@end
