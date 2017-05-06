//
//  WeatherDetailHeadView.m
//  GraduationProject
//
//  Created by MS on 17/3/16.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WeatherDetailHeadView.h"
#import <Masonry.h>
#import "WBConfig.h"
#import <YYText.h>

@interface WeatherDetailHeadView ()

//城市名字
@property(nonatomic,strong)UILabel* cityName;
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
//建议
@property(nonatomic,strong)YYLabel* advice;

@end

@implementation WeatherDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self cityName];
        [self date];
        [self temperature];
        [self wind];
        [self weatherImage];
        [self weather];
        [self advice];
    }
    return self;
}

-(void)setDataSource:(WeatherTodayModel *)dataSource{
    if (dataSource.city) {
        self.cityName.text = dataSource.city;
    }
    
    if (dataSource.date_y) {
        self.date.text = dataSource.date_y;
    }
    
    if (dataSource.temperature) {
        self.temperature.text = dataSource.temperature;
    }
    
    if (dataSource.weather) {
        self.weather.text = dataSource.weather;
    }
    
    if (dataSource.wind) {
        self.wind.text = dataSource.wind;
    }
    /*
     天气类型有好多种。这里暂时只判断4种。这个应该单独一个类来进行天气种类的判断
     */
    if (dataSource.weather_id.fa) {
        //天气晴
        if ([dataSource.weather_id.fa intValue] == 00) {
            self.weatherImage.image = [UIImage imageNamed:@"w0"];
        }
        //天气霾
        if ([dataSource.weather_id.fa intValue] == 53) {
            self.weatherImage.image = [UIImage imageNamed:@"w18"];
        }
        //多云
        if ([dataSource.weather_id.fa intValue] == 01) {
            self.weatherImage.image = [UIImage imageNamed:@"w1"];
        }
        //阴
        if ([dataSource.weather_id.fa intValue] == 02) {
            self.weatherImage.image = [UIImage imageNamed:@"w2"];
        }
    }
    
    if (dataSource.dressing_advice) {
        self.advice.text = dataSource.dressing_advice;
        self.advice.textLayout = [self textLayout:dataSource.dressing_advice size:CGSizeMake(SCREENWIDTH - 30, 50)];
    }
}

#pragma mark - 获取文本布局
-(YYTextLayout*)textLayout:(NSString*)string size:(CGSize)size{
    //创建文本容器
    YYTextContainer* container = [YYTextContainer containerWithSize:size];
    container.maximumNumberOfRows = 0;
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //生成排版结果
    YYTextLayout* textLayout = [YYTextLayout layoutWithContainer:container text:attStr];
    return textLayout;
}

-(void)layoutSubviews{
    [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 40));
        make.top.equalTo(self.mas_top).with.offset(15);
        make.leading.equalTo(self.mas_leading).with.offset(30);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20));
        make.top.equalTo(self.cityName.mas_bottom).with.offset(10);
        make.leading.equalTo(self.mas_leading).with.offset(30);
    }];
    
    [self.temperature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
        make.top.equalTo(self.date.mas_bottom).with.offset(15);
        make.leading.equalTo(self.mas_leading).with.offset(30);
    }];
    
    [self.wind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
        make.top.equalTo(self.temperature.mas_bottom).with.offset(15);
        make.leading.equalTo(self.mas_leading).with.offset(30);
    }];
    
    [self.weatherImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.mas_top).with.offset(30);
        make.trailing.equalTo(self.mas_trailing).with.offset(-70);
    }];
    
    [self.weather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.top.equalTo(self.weatherImage.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.weatherImage.mas_centerX);
    }];
    
    [self.advice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 50));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.wind.mas_bottom).with.offset(10);
    }];
}

#pragma mark - 懒加载
-(UILabel *)cityName{
    if (!_cityName) {
        _cityName = [[UILabel alloc] init];
        _cityName.textAlignment = NSTextAlignmentCenter;
        _cityName.font = [UIFont boldSystemFontOfSize:20];
        _cityName.textColor = [UIColor whiteColor];
        [self addSubview:_cityName];
    }
    return _cityName;
}

-(UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.textColor = [UIColor whiteColor];
        [self addSubview:_date];
    }
    return _date;
}

-(UILabel *)temperature{
    if (!_temperature) {
        _temperature = [[UILabel alloc] init];
        _temperature.textAlignment = NSTextAlignmentCenter;
        _temperature.textColor = [UIColor whiteColor];
        _temperature.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:_temperature];
    }
    return _temperature;
}

-(UILabel *)weather{
    if (!_weather) {
        _weather = [[UILabel alloc] init];
        _weather.textColor = [UIColor whiteColor];
        _weather.textAlignment = NSTextAlignmentCenter;
        _weather.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:_weather];
    }
    return _weather;
}

-(UILabel *)wind{
    if (!_wind) {
        _wind = [[UILabel alloc] init];
        _wind.textColor = [UIColor whiteColor];
        _wind.textAlignment = NSTextAlignmentCenter;
        _wind.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:_wind];
    }
    return _wind;
}

-(UIImageView *)weatherImage{
    if (!_weatherImage) {
        _weatherImage = [[UIImageView alloc] init];
        [self addSubview:_weatherImage];
    }
    return _weatherImage;
}

-(YYLabel *)advice{
    if (!_advice) {
        _advice = [[YYLabel alloc] init];
        _advice.numberOfLines = 0;
        //开启异步绘制
        _advice.displaysAsynchronously = YES;
        _advice.ignoreCommonProperties = YES;
        _advice.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        [self addSubview:_advice];
    }
    return _advice;
}

@end
