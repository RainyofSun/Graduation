//
//  HotelDetailVC.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "HotelDetailVC.h"
#import "WBIntroduceFile.h"
#import "HotelDetailModel.h"
#import "GroupBuyingReqeust.h"
#import "HotelDetailView.h"
#import "UrlVC.h"
#import "ShowGDMap.h"

@interface HotelDetailVC ()<HotelDetailViewDelegate>

@property(nonatomic,strong)HotelDetailView* detailView;

@end

@implementation HotelDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒店详情";
    [self detailView];
    [self getHotelDetail:self.data.id];
    self.detailView.model = self.data;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavItemWithImage:@"ios7_top_navigation_locationicon" target:self action:@selector(hotelLocation:) type:1];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 获取hotel详情
-(void)getHotelDetail:(NSString*)hotelId{
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] getHotelDetailMessage:hotelId sucess:^(NSDictionary *dict) {
        [weakSelf performOnMainThread:^{
            HotelDetailModel* model = [HotelDetailModel modelWithDictionary:dict];
            weakSelf.detailView.hotelMessage.text = model.intro;
            weakSelf.detailView.hotelMessage.textLayout = [weakSelf getTextlayoutWithStr:model.intro size:CGSizeMake(SCREENWIDTH - 30, 100)];
            weakSelf.detailView.hotelService.text = model.serve;
            weakSelf.detailView.hotelService.textLayout = [weakSelf getTextlayoutWithStr:model.serve size:CGSizeMake(SCREENWIDTH - 30, 60)];
            weakSelf.detailView.hotelPolicy.text = model.policy;
            weakSelf.detailView.hotelPolicy.textLayout = [weakSelf getTextlayoutWithStr:model.policy size:CGSizeMake(SCREENWIDTH - 30, 50)];
            weakSelf.detailView.hotelRoomSetting.text = model.roomFacility;
            weakSelf.detailView.hotelRoomSetting.textLayout = [weakSelf getTextlayoutWithStr:model.roomFacility size:CGSizeMake(SCREENWIDTH - 30, 70)];
            weakSelf.detailView.hotelSetting.text = model.hotelFacilities;
            weakSelf.detailView.hotelSetting.textLayout = [weakSelf getTextlayoutWithStr:model.hotelFacilities size:CGSizeMake(SCREENWIDTH - 30, 30)];
            weakSelf.detailView.foodSetting.text = model.foodfunf;
        } wait:NO];
    }];
}

-(YYTextLayout*)getTextlayoutWithStr:(NSString*)str size:(CGSize)size{
    YYTextContainer* container = [YYTextContainer containerWithSize:size];
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return [YYTextLayout layoutWithContainer:container text:attStr];
}

#pragma mark - HotelDetailViewDelegate
-(void)customHotelSetting:(id)sender{
    UrlVC* url = [[UrlVC alloc] init];
    url.connection = self.data.url;
    [self pushVc:url];
}

#pragma mark - hotel locations
-(void)hotelLocation:(UIGestureRecognizer*)sender{
    ShowGDMap* map = [[ShowGDMap alloc] init];
    map.location = @{@"lon":[NSString stringWithFormat:@"%@",self.data.Lon],
                     @"lat":[NSString stringWithFormat:@"%@",self.data.Lat]};
    map.storeName = self.data.name;
    map.storeAddress = self.data.address;
    [self pushVc:map];
}

#pragma mark - 懒加载
-(HotelDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[HotelDetailView alloc] init];
        [self.view addSubview:_detailView];
        _detailView.delegate = self;
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
    }
    return _detailView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
