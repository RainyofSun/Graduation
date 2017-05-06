//
//  HotelDetailView.m
//  GraduationProject
//
//  Created by MS on 17/3/26.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "HotelDetailView.h"
#import "WBConfig.h"
#import "WBBaseImageView.h"
#import <Masonry.h>

@interface HotelDetailView ()
//酒店图片
@property(nonatomic,strong)WBBaseImageView* hotelPic;
//酒店名字
@property(nonatomic,strong)UILabel* hotelName;
//酒店性质
@property(nonatomic,strong)UILabel* hotelNature;
//酒店地址
@property(nonatomic,strong)UILabel* hotelAddress;
//酒店详情
@property(nonatomic,strong)UILabel* hotel;
//马上入住
@property(nonatomic,strong)UIButton* customHotel;

@end

@implementation HotelDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self hotelPic];
        [self hotelName];
        [self hotelNature];
        [self customHotel];
        [self hotelAddress];
        [self hotel];
        [self hotelMessage];
        [self hotelService];
        [self hotelRoomSetting];
        [self hotelSetting];
        [self foodSetting];
        [self hotelPolicy];
    }
    return self;
}

-(void)custom:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(customHotelSetting:)]) {
        [self.delegate customHotelSetting:self];
    }
}

-(void)setModel:(HotelListModel *)model{
    if (model.largePic) {
        [self.hotelPic setImageWithUrl:model.largePic];
    }
    
    if (model.name) {
        self.hotelName.text = model.name;
    }
    
    if (model.className && model.manyidu) {
        self.hotelNature.text = [NSString stringWithFormat:@"%@   满意度:%@",model.className,model.manyidu];
    }
    
    if (model.address) {
        self.hotelAddress.text = model.address;
    }
}

-(void)layoutSubviews{
    [self.hotelPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self);
        make.height.mas_equalTo(SCREENHEIGHT/4);
    }];
    
    [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.hotelPic.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
    }];
    
    [self.hotelNature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/2, 20));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelName.mas_bottom).with.offset(3);
    }];
    
    [self.customHotel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.centerY.equalTo(self.hotelNature.mas_centerY);
        make.leading.equalTo(self.hotelNature.mas_trailing).with.offset(20);
    }];
    
    [self.hotelAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelNature.mas_bottom).with.offset(3);
    }];
    
    [self.hotel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelAddress.mas_bottom).with.offset(3);
    }];
    
    [self.hotelMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 100));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotel.mas_bottom).with.offset(10);
    }];
    
    [self.hotelService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 60));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelMessage.mas_bottom).with.offset(3);
    }];
    
    [self.hotelRoomSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 70));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelService.mas_bottom).with.offset(3);
    }];
    
    [self.hotelSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelRoomSetting.mas_bottom).with.offset(3);
    }];
    
    [self.foodSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelSetting.mas_bottom).with.offset(3);
    }];
    
    [self.hotelPolicy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 50));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.foodSetting.mas_bottom).with.offset(10);
    }];
}

#pragma mark - 懒加载
-(WBBaseImageView *)hotelPic{
    if (!_hotelPic) {
        _hotelPic = [[WBBaseImageView alloc] init];
        [self addSubview:_hotelPic];
    }
    return _hotelPic;
}

-(UILabel *)hotelName{
    if (!_hotelName) {
        _hotelName = [[UILabel alloc] init];
        [self addSubview:_hotelName];
    }
    return _hotelName;
}

-(UILabel *)hotelNature{
    if (!_hotelNature) {
        _hotelNature = [[UILabel alloc] init];
        [self addSubview:_hotelNature];
    }
    return _hotelNature;
}

-(UIButton *)customHotel{
    if (!_customHotel) {
        _customHotel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customHotel setTitle:@"马上入住" forState:UIControlStateNormal];
        _customHotel.titleLabel.font = [UIFont systemFontOfSize:13];
        _customHotel.backgroundColor = [UIColor orangeColor];
        [_customHotel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _customHotel.layer.cornerRadius = 5.0f;
        _customHotel.layer.masksToBounds = YES;
        [_customHotel addTarget:self action:@selector(custom:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_customHotel];
    }
    return _customHotel;
}

-(UILabel *)hotelAddress{
    if (!_hotelAddress) {
        _hotelAddress = [[UILabel alloc] init];
        [self addSubview:_hotelAddress];
    }
    return _hotelAddress;
}

-(UILabel *)hotel{
    if (!_hotel) {
        _hotel = [[UILabel alloc] init];
        _hotel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"酒店详情:" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor orangeColor]}];
        [self addSubview:_hotel];
    }
    return _hotel;
}
-(UILabel *)foodSetting{
    if (!_foodSetting) {
        _foodSetting = [[UILabel alloc] init];
        [self addSubview:_foodSetting];
    }
    return _foodSetting;
}

-(YYLabel *)hotelMessage{
    if (!_hotelMessage) {
        _hotelMessage = [[YYLabel alloc] init];
        _hotelMessage.ignoreCommonProperties = YES;
        _hotelMessage.displaysAsynchronously = YES;
        _hotelMessage.numberOfLines = 0;
        [self addSubview:_hotelMessage];
    }
    return _hotelMessage;
}

-(YYLabel *)hotelService{
    if (!_hotelService) {
        _hotelService = [[YYLabel alloc] init];
        _hotelService.ignoreCommonProperties = YES;
        _hotelService.displaysAsynchronously = YES;
        _hotelService.numberOfLines = 0;
        [self addSubview:_hotelService];
    }
    return _hotelService;
}


-(YYLabel *)hotelSetting{
    if (!_hotelSetting) {
        _hotelSetting = [[YYLabel alloc] init];
        _hotelSetting.ignoreCommonProperties = YES;
        _hotelSetting.displaysAsynchronously = YES;
        _hotelSetting.numberOfLines = 0;
        [self addSubview:_hotelSetting];
    }
    return _hotelSetting;
}


-(YYLabel *)hotelRoomSetting{
    if (!_hotelRoomSetting) {
        _hotelRoomSetting = [[YYLabel alloc] init];
        _hotelRoomSetting.ignoreCommonProperties = YES;
        _hotelRoomSetting.displaysAsynchronously = YES;
        _hotelRoomSetting.numberOfLines = 0;
        [self addSubview:_hotelRoomSetting];
    }
    return _hotelRoomSetting;
}

-(YYLabel *)hotelPolicy{
    if (!_hotelPolicy) {
        _hotelPolicy = [[YYLabel alloc] init];
        _hotelPolicy.ignoreCommonProperties = YES;
        _hotelPolicy.displaysAsynchronously = YES;
        _hotelPolicy.numberOfLines = 0;
        [self addSubview:_hotelPolicy];
    }
    return _hotelPolicy;
}

@end
