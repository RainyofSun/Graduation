//
//  WeatherDetailCell.m
//  GraduationProject
//
//  Created by MS on 17/3/17.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WeatherDetailCell.h"
#import <Masonry.h>
#import "WBConfig.h"

@interface WeatherDetailCell ()

//日期
@property(nonatomic,strong)UILabel* date;
//温度
@property(nonatomic,strong)UILabel* temperature;
//天气
@property(nonatomic,strong)UILabel* weather;
//风向
@property(nonatomic,strong)UILabel* wind;
//天气图片
@property(nonatomic,strong)UIImageView* weatherImage;

@end

@implementation WeatherDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];//设置cell背景透明
        [self weatherImage];
        [self date];
        [self temperature];
        [self weather];
        [self wind];
    }
    return self;
}

-(void)setFutureModel:(WeatherFutureModel *)futureModel{
    if (futureModel.date) {
        self.date.text = futureModel.date;
    }
    
    if (futureModel.temperature) {
        self.temperature.text = futureModel.temperature;
    }
    
    if (futureModel.weather) {
        self.weather.text = futureModel.weather;
    }
    
    if (futureModel.wind) {
        self.wind.text = futureModel.wind;
    }
    /*
     天气类型有好多种。这里暂时只判断4种。这个应该单独一个类来进行天气种类的判断
     */
    if (futureModel.weather_id.fa) {
        //天气晴
        if ([futureModel.weather_id.fa intValue] == 00) {
            self.weatherImage.image = [UIImage imageNamed:@"w0"];
        }
        //天气霾
        if ([futureModel.weather_id.fa intValue] == 53) {
            self.weatherImage.image = [UIImage imageNamed:@"w18"];
        }
        //多云
        if ([futureModel.weather_id.fa intValue] == 01) {
            self.weatherImage.image = [UIImage imageNamed:@"w1"];
        }
        //阴
        if ([futureModel.weather_id.fa intValue] == 02) {
            self.weatherImage.image = [UIImage imageNamed:@"w2"];
        }
    }
}

-(void)layoutSubviews{
    [self.weatherImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.leading.equalTo(self.contentView.mas_leading).with.offset(8);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];

    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.leading.equalTo(self.weatherImage.mas_trailing).with.offset(15);
    }];
   
    [self.temperature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
        make.top.equalTo(self.date.mas_bottom).with.offset(10);
        make.leading.equalTo(self.weatherImage.mas_trailing).with.offset(15);
    }];
   
    [self.weather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.leading.equalTo(self.date.mas_trailing).with.offset(20);
    }];
    
    [self.wind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
        make.top.equalTo(self.weather.mas_bottom).with.offset(10);
        make.leading.equalTo(self.temperature.mas_trailing).with.offset(20);
    }];
}

#pragma mark - 懒加载
-(UIImageView *)weatherImage{
    if (!_weatherImage) {
        _weatherImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_weatherImage];
    }
    return _weatherImage;
}

-(UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.textColor = [UIColor whiteColor];
        _date.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_date];
    }
    return _date;
}

-(UILabel *)temperature{
    if (!_temperature) {
        _temperature = [[UILabel alloc] init];
        _temperature.textAlignment = NSTextAlignmentCenter;
        _temperature.textColor = [UIColor whiteColor];
        _temperature.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_temperature];
    }
    return _temperature;
}

-(UILabel *)weather{
    if (!_weather) {
        _weather = [[UILabel alloc] init];
        _weather.textColor = [UIColor whiteColor];
        _weather.textAlignment = NSTextAlignmentCenter;
        _weather.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_weather];
    }
    return _weather;
}

-(UILabel *)wind{
    if (!_wind) {
        _wind = [[UILabel alloc] init];
        _wind.textColor = [UIColor whiteColor];
        _wind.textAlignment = NSTextAlignmentCenter;
        _wind.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_wind];
    }
    return _wind;
}

@end
