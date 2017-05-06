//
//  HotelVC.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "HotelVC.h"
#import "WBIntroduceFile.h"
#import "GroupBuyingReqeust.h"
#import "HotelCityListModel.h"
#import "WBBaseTableView.h"
#import "HotelListCell.h"
#import "HotelDetailVC.h"

static NSUInteger page;
@interface HotelVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray* cityList;
@property(nonatomic,strong)NSMutableArray* hotelList;
@property(nonatomic,strong)WBBaseTableView* tableView;
/**标记--->是否是下拉刷新还是下拉加载*/
@property(nonatomic,assign)BOOL isRefresh;

@end

@implementation HotelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒店";
    [self tableView];
    page = 1;
    self.isRefresh = NO;//默认是上拉加载
//    [self getCityList];
}

#pragma mark - 获取城市列表
-(void)getCityList{
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] getCityListSucess:^(NSMutableArray *dataSource) {
        [weakSelf.cityList addObjectsFromArray:dataSource];
        for (int i = 0; i < weakSelf.cityList.count; i++) {
            HotelCityListModel* model = weakSelf.cityList[i];
            if ([model.cityName isEqualToString:weakSelf.cityName]) {
                [self getHotelListWithId:model.cityId page:[NSString stringWithFormat:@"%ld",(unsigned long)page]];
                break;
            }
        }
    }];
}

-(void)getHotelListWithId:(NSString*)cityId page:(NSString*)page{
    if ([cityId isKindOfClass:[NSNull class]] || cityId == nil) {
        return;
    }
    [self showLoadingAnimation];
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] getHotelListWithCityId:cityId page:page sucess:^(NSMutableArray *dataSource) {
        [weakSelf performOnMainThread:^{
            [weakSelf stopLoadingAnimation];
            [weakSelf.hotelList addObjectsFromArray:dataSource];
            [weakSelf.tableView reloadData];
            //停止加载
            [self tableViewStopLodingMore:weakSelf.tableView dataSource:weakSelf.hotelList];
            //停止刷新
            [self tableViewStopRefresh:self.tableView];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotelList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelListCell* cell = [HotelListCell cellWithTableView:tableView];
    cell.dataSource = self.hotelList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelDetailVC* detail = [[HotelDetailVC alloc] init];
    detail.data = self.hotelList[indexPath.row];
    [self pushVc:detail];
}

#pragma mark - 懒加载
-(NSMutableArray *)cityList{
    if (!_cityList) {
        _cityList = [NSMutableArray array];
    }
    return _cityList;
}

-(NSMutableArray *)hotelList{
    if (!_hotelList) {
        _hotelList = [NSMutableArray array];
    }
    return _hotelList;
}

-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
        [self tabelVewRefresh:_tableView actionBlock:^{
            page = 1;
            self.isRefresh = YES;
            [self getCityList];
        }];
        [self tableViewLoadingMore:_tableView actionBlock:^{
            self.isRefresh = NO;
            page++;
            [self getCityList];
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
