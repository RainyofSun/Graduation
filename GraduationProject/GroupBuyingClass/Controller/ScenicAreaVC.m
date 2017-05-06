//
//  ScenicAreaVC.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
/*
 刷新有问题
 */

#import "ScenicAreaVC.h"
#import "WBIntroduceFile.h"
#import "WBBaseTableView.h"
#import "GroupBuyingReqeust.h"
#import "HotelCityListModel.h"
#import "ScenicAreaListCell.h"
#import "ScenicAreaDetailVC.h"

static NSInteger page;
@interface ScenicAreaVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray* cityList;
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,strong)WBBaseTableView* tableView;
/**标记--->是否是下拉刷新还是下拉加载*/
@property(nonatomic,assign)BOOL isRefresh;

@end

@implementation ScenicAreaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    page = 1;
    self.title = @"景点";
    self.isRefresh = NO;//默认是上拉加载
    [self getCityList];
}

#pragma mark - 获取城市列表
-(void)getCityList{
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] getCityListSucess:^(NSMutableArray *dataSource) {
        [weakSelf.cityList addObjectsFromArray:dataSource];
        for (int i = 0; i < weakSelf.cityList.count; i++) {
            HotelCityListModel* model = weakSelf.cityList[i];
            if ([model.cityName isEqualToString:weakSelf.cityName]) {
                [self getSpotWithCityName:model.cityId page:[NSString stringWithFormat:@"%ld",(long)page]];
                break;
            }
        }
    }];
}

#pragma mark - 获取景点数据
-(void)getSpotWithCityName:(NSString*)cityid page:(NSString*)pageNum{
    [SVProgressHUD showInfoWithStatus:@"数据加载中..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] getScenicAreaList:cityid page:pageNum sucess:^(NSMutableArray *dataSource) {
        [SVProgressHUD dismiss];
        [weakSelf performOnMainThread:^{
            [weakSelf stopLoadingAnimation];
            [weakSelf.dataSource addObjectsFromArray:dataSource];
            [weakSelf.tableView reloadData];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScenicAreaListCell* cell = [ScenicAreaListCell cellWithTableView:tableView];
    cell.dataSource = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScenicAreaDetailVC* detail = [[ScenicAreaDetailVC alloc] init];
    detail.spot = self.dataSource[indexPath.row];
    [self pushVc:detail];
}

#pragma mark - 懒加载
-(NSMutableArray *)cityList{
    if (!_cityList) {
        _cityList = [NSMutableArray array];
    }
    return _cityList;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
