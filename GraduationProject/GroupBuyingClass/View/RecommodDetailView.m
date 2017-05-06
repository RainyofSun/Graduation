//
//  RecommodDetailView.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "RecommodDetailView.h"
#import <Masonry.h>
#import "BaseImageView.h"
#import "WBConfig.h"
#import "XHStarRateView.h"
#import <YYText.h>
#import "ACMacros.h"
#import "UIView+Tap.h"

@interface RecommodDetailView ()

@property(nonatomic,strong)GroupBuyingModel* model;
@property(nonatomic,strong)BaseImageView* head;
//店铺名字
@property(nonatomic,strong)UILabel* storeName;
//评价
@property(nonatomic,strong)XHStarRateView* startView;
//人均消费
@property(nonatomic,strong)UILabel* average_fee;
//标签
@property(nonatomic,strong)UILabel* tags;
//推荐菜色
@property(nonatomic,strong)YYLabel* recommendDish;
@property(nonatomic,strong)UILabel* recomond;
//综合评分
@property(nonatomic,strong)UILabel* totalComment;
//评论条数
@property(nonatomic,strong)UILabel* commenCount;
//产品评分
@property(nonatomic,strong)XHStarRateView* product;
@property(nonatomic,strong)UILabel* productLabel;
//环境评分
@property(nonatomic,strong)XHStarRateView* envirment;
@property(nonatomic,strong)UILabel* envirmentLabel;
//服务评分
@property(nonatomic,strong)XHStarRateView* service;
@property(nonatomic,strong)UILabel* serviceLabel;

//打电话
@property(nonatomic,strong)UILabel* call;

@end

@implementation RecommodDetailView

-(instancetype)initWithFrame:(CGRect)frame data:(GroupBuyingModel *)model{
    if (self = [super initWithFrame:frame]) {
        self.model = model;
        [self head];
        [self storeName];
        [self startView];
        [self average_fee];
        [self tags];
        [self recommendDish];
        [self recomond];
        [self totalComment];
        [self commenCount];
        [self product];
        [self productLabel];
        [self envirment];
        [self envirmentLabel];
        [self service];
        [self serviceLabel];
        [self call];
        [self loadData:model];
    }
    return self;
}

#pragma mark - 点击方法
-(void)makeCall:(UIGestureRecognizer*)sender{
    if (self.model.phone) {
        if ([self.model.phone containsString:@","]) {
            NSArray* callNum = [self.model.phone componentsSeparatedByString:@","];
            [self makeAcall:callNum[0]];
        }else{
            [self makeAcall:self.model.phone];
        }
    }
}

-(void)makeAcall:(NSString*)num{
    UIWebView * callWebview = [[UIWebView alloc]init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",num]]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

-(void)loadData:(GroupBuyingModel*)data{
    if (data.photos) {
        [self.head setImageWithUrl:data.photos];
    }
    
    if (data.name) {
        self.storeName.text = data.name;
    }
    
    if (data.stars) {
        self.startView.currentScore = data.stars;
    }
    
    if (data.avg_price) {
        self.average_fee.text = AppendString(@"人均¥%@", data.avg_price);
    }
    
    if (data.tags) {
        self.tags.text = data.tags;
    }
    
    if (data.recommended_dishes) {
        self.recommendDish.text = data.recommended_dishes;
        self.recommendDish.textLayout = [self getTextlayoutWithStr:data.recommended_dishes];
    }
    
    self.productLabel.text = @"产品环境:";
    self.serviceLabel.text = @"服务环境:";
    self.envirmentLabel.text = @"环境评分:";
    self.recomond.text = @"推荐菜色:";
    if (data.product_rating) {
        if ([data.product_rating intValue] > 5) {
            self.product.currentScore = [data.product_rating intValue] - 5;
        }else{
            self.product.currentScore = [data.product_rating intValue];
        }
    }else{
        self.product.currentScore = 0;
    }
    
    if (data.service_rating) {
        if ([data.service_rating intValue] > 5) {
            self.service.currentScore = [data.service_rating intValue] - 5;
        }else{
            self.service.currentScore = [data.service_rating intValue];
        }
    }else{
        self.service.currentScore = 0;
    }
    
    if (data.environment_rating) {
        if ([data.environment_rating intValue] > 5) {
            self.envirment.currentScore = [data.environment_rating intValue] - 5;
        }else{
            self.envirment.currentScore = [data.environment_rating intValue];
        }
    }else{
        self.envirment.currentScore = 0;
    }
    
    if (data.stars) {
        NSString* mark = [NSString stringWithFormat:@"%f",data.stars];
        NSString* remark = [NSString stringWithFormat:@"%@分",[mark substringToIndex:3]];
        NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:remark];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28]} range:NSMakeRange(0, remark.length - 1)];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(remark.length-1, 1)];
        self.totalComment.attributedText = attStr;
    }
    
    if (data.all_remarks) {
        self.commenCount.text = AppendString(@"总点评数:%d", data.all_remarks);
    }
    
    if (data.phone) {
        self.call.text = AppendString(@"订餐电话: %@", data.phone);
    }
}

-(YYTextLayout*)getTextlayoutWithStr:(NSString*)str{
    YYTextContainer* container = [YYTextContainer containerWithSize:CGSizeMake(SCREENWIDTH - 30, 30)];
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return [YYTextLayout layoutWithContainer:container text:attStr];
}

-(void)layoutSubviews{
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self);
        make.height.mas_equalTo(SCREENHEIGHT/4);
    }];
    
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.head.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 40));
    }];
    
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.left.equalTo(self.storeName);
        make.top.equalTo(self.storeName.mas_bottom).with.offset(3);
    }];
    
    [self.average_fee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeName.mas_bottom).with.offset(3);
        make.leading.equalTo(self.startView.mas_trailing).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
    }];
    
    [self.tags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.left.equalTo(self.storeName);
        make.top.equalTo(self.average_fee.mas_bottom).with.offset(3);
    }];
    
    [self.recomond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeName);
        make.top.equalTo(self.tags.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 30));
    }];
    
    [self.recommendDish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 30));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.recomond.mas_bottom).with.offset(5);
    }];
    
    [self.totalComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 80));
        make.left.equalTo(self.storeName);
        make.top.equalTo(self.recommendDish.mas_bottom).with.offset(30);
    }];
    
    [self.commenCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalComment);
        make.top.equalTo(self.totalComment.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.leading.equalTo(self.totalComment.mas_trailing).with.offset(10);
        make.top.equalTo(self.totalComment);
    }];
    
    [self.product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.leading.equalTo(self.productLabel.mas_trailing).with.offset(10);
        make.top.equalTo(self.totalComment);
    }];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.leading.equalTo(self.totalComment.mas_trailing).with.offset(10);
        make.top.equalTo(self.product.mas_bottom).with.offset(10);
    }];
    
    [self.service mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.leading.equalTo(self.serviceLabel.mas_trailing).with.offset(10);
        make.top.equalTo(self.product.mas_bottom).with.offset(10);
    }];
    
    [self.envirmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.leading.equalTo(self.totalComment.mas_trailing).with.offset(10);
        make.top.equalTo(self.service.mas_bottom).with.offset(10);
    }];
    
    [self.envirment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.leading.equalTo(self.envirmentLabel.mas_trailing).with.offset(10);
        make.top.equalTo(self.service.mas_bottom).with.offset(10);
    }];
    
    [self.call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-30, 40));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.envirment.mas_bottom).with.offset(20);
    }];
}

#pragma mark - 懒加载
-(BaseImageView *)head{
    if (!_head) {
        _head = [[BaseImageView alloc] init];
        [self addSubview:_head];
    }
    return _head;
}

-(UILabel *)storeName{
    if (!_storeName) {
        _storeName = [[UILabel alloc] init];
        [self addSubview:_storeName];
    }
    return _storeName;
}

-(XHStarRateView *)startView{
    if (!_startView) {
        _startView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _startView.rateStyle = IncompleteStar;
        [self addSubview:_startView];
    }
    return _startView;
}

-(UILabel *)average_fee{
    if (!_average_fee) {
        _average_fee = [[UILabel alloc] init];
        [self addSubview:_average_fee];
    }
    return _average_fee;
}

-(UILabel *)tags{
    if (!_tags) {
        _tags = [[UILabel alloc] init];
        _tags.font = [UIFont systemFontOfSize:13];
        [self addSubview:_tags];
    }
    return _tags;
}

-(YYLabel *)recommendDish{
    if (!_recommendDish) {
        _recommendDish = [[YYLabel alloc] init];
        //开启异步绘制
        _recommendDish.displaysAsynchronously = YES;
        _recommendDish.ignoreCommonProperties = YES;
        _recommendDish.numberOfLines = 0;
        _recommendDish.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        [self addSubview:_recommendDish];
    }
    return _recommendDish;
}

-(UILabel *)recomond{
    if (!_recomond) {
        _recomond = [[UILabel alloc] init];
        _recomond.textColor = [UIColor orangeColor];
        _recomond.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_recomond];
    }
    return _recomond;
}

-(UILabel *)totalComment{
    if (!_totalComment) {
        _totalComment = [[UILabel alloc] init];
        _totalComment.textColor = [UIColor orangeColor];
        _totalComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_totalComment];
    }
    return _totalComment;
}

-(UILabel *)commenCount{
    if (!_commenCount) {
        _commenCount = [[UILabel alloc] init];
        _commenCount.font = [UIFont systemFontOfSize:12];
        [self addSubview:_commenCount];
    }
    return _commenCount;
}

-(XHStarRateView *)product{
    if (!_product) {
        _product = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _product.rateStyle = IncompleteStar;
        [self addSubview:_product];
    }
    return _product;
}

-(XHStarRateView *)service{
    if (!_service) {
        _service = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _service.rateStyle = IncompleteStar;
        [self addSubview:_service];
    }
    return _service;
}
-(XHStarRateView *)envirment{
    if (!_envirment) {
        _envirment = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _envirment.rateStyle = IncompleteStar;
        [self addSubview:_envirment];
    }
    return _envirment;
}

-(UILabel *)productLabel{
    if (!_productLabel) {
        _productLabel = [[UILabel alloc] init];
        [self addSubview:_productLabel];
    }
    return _productLabel;
}

-(UILabel *)serviceLabel{
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc] init];
        [self addSubview:_serviceLabel];
    }
    return _serviceLabel;
}

-(UILabel *)envirmentLabel{
    if (!_envirmentLabel) {
        _envirmentLabel = [[UILabel alloc] init];
        [self addSubview:_envirmentLabel];
    }
    return _envirmentLabel;
}

-(UILabel *)call{
    if (!_call) {
        _call = [[UILabel alloc] init];
        _call.userInteractionEnabled = YES;
        [_call setTapTarget:self action:@selector(makeCall:)];
        [self addSubview:_call];
    }
    return _call;
}

@end
