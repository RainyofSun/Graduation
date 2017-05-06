//
//  HotelListCell.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "HotelListCell.h"
#import "WBBaseImageView.h"
#import "ACMacros.h"
#import <Masonry.h>
#import <YYText.h>

@interface HotelListCell ()

//酒店图片
@property(nonatomic,strong)WBBaseImageView* hotelPic;
//酒店名字
@property(nonatomic,strong)UILabel* hotelName;
//酒店星级
@property(nonatomic,strong)UILabel* hotelStars;
//酒店满意度
@property(nonatomic,strong)UILabel* hotelSatisfy;
//酒店交通
@property(nonatomic,strong)YYLabel* transport;
//酒店地址
@property(nonatomic,strong)UILabel* hotelAddress;

@end

@implementation HotelListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self hotelPic];
        [self hotelName];
        [self hotelStars];
        [self hotelSatisfy];
        [self hotelAddress];
        [self transport];
    }
    return self;
}

-(void)setDataSource:(HotelListModel *)dataSource{
    if (dataSource.largePic) {
        [self.hotelPic setImageWithUrl:dataSource.largePic];
    }
    
    if (dataSource.name) {
        self.hotelName.text = dataSource.name;
    }
    
    if (dataSource.className) {
        self.hotelStars.text = dataSource.className;
    }
    
    if (dataSource.manyidu) {
        self.hotelSatisfy.text = AppendString(@"满意度: %@", dataSource.manyidu);
    }
    
    if (dataSource.address) {
        self.hotelAddress.text = dataSource.address;
    }
    
    if (dataSource.intro) {
        self.transport.text = dataSource.intro;
        self.transport.textLayout = [self getTextLayout:dataSource.intro];
    }
}

-(YYTextLayout*)getTextLayout:(NSString*)string{
    YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(Main_Screen_Width - 100, 60)];
    NSMutableAttributedString* arrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return [YYTextLayout layoutWithContainer:container text:arrStr];
}

-(void)layoutSubviews{
    [self.hotelPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 100));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(8);
    }];
    
    [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 100, 30));
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
        make.leading.equalTo(self.hotelPic.mas_trailing).with.offset(3);
    }];
    
    [self.hotelStars mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelName.mas_bottom).with.offset(3);
    }];
    
    [self.hotelSatisfy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.leading.equalTo(self.hotelStars.mas_trailing).with.offset(5);
        make.centerY.equalTo(self.hotelStars.mas_centerY);
    }];
    
    [self.hotelAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width/2, 30));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelStars.mas_bottom).with.offset(3);
    }];
    
    [self.transport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Main_Screen_Width - 100, 70));
        make.left.equalTo(self.hotelName);
        make.top.equalTo(self.hotelAddress.mas_bottom).with.offset(3);
    }];
}

#pragma mark - 懒加载
-(WBBaseImageView *)hotelPic{
    if (!_hotelPic) {
        _hotelPic = [[WBBaseImageView alloc] init];
        _hotelPic.layer.cornerRadius = 5.0f;
        _hotelPic.layer.masksToBounds = YES;
        [self.contentView addSubview:_hotelPic];
    }
    return _hotelPic;
}

-(UILabel *)hotelName{
    if (!_hotelName) {
        _hotelName = [[UILabel alloc] init];
        [self.contentView addSubview:_hotelName];
    }
    return _hotelName;
}

-(UILabel *)hotelStars{
    if (!_hotelStars) {
        _hotelStars = [[UILabel alloc] init];
        _hotelStars.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_hotelStars];
    }
    return _hotelStars;
}

-(UILabel *)hotelSatisfy{
    if (!_hotelSatisfy) {
        _hotelSatisfy = [[UILabel alloc] init];
        _hotelSatisfy.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_hotelSatisfy];
    }
    return _hotelSatisfy;
}

-(UILabel *)hotelAddress{
    if (!_hotelAddress) {
        _hotelAddress = [[UILabel alloc] init];
        [self.contentView addSubview:_hotelAddress];
    }
    return _hotelAddress;
}

-(YYLabel *)transport{
    if (!_transport) {
        _transport = [[YYLabel alloc] init];
        _transport.numberOfLines = 0;
        _transport.ignoreCommonProperties = YES;
        _transport.displaysAsynchronously = YES;
        [self.contentView addSubview:_transport];
    }
    return _transport;
}
@end
