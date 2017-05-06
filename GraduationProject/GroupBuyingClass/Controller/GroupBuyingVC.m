//
//  GroupBuyingVC.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "GroupBuyingVC.h"
#import "WBIntroduceFile.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import "ShowGDMap.h"
#import "GroupBuyingReqeust.h"
#import "GroupBuyinyRecommondCell.h"
#import "GroupBuyingHeadView.h"
#import "DeliciousFoodVC.h"
#import "HotelVC.h"
#import "ScenicAreaVC.h"
#import "MovieVC.h"
#import "RecommondDetailVC.h"

static NSInteger page;
@interface GroupBuyingVC ()<UITableViewDelegate,UITableViewDataSource,GroupBuyingHeadViewDeleagte>

/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;
@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;
/**标记--->是否是下拉刷新还是下拉加载*/
@property(nonatomic,assign)BOOL isRefresh;

@end

@implementation GroupBuyingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavItemWithTitle:@"北京" target:self action:@selector(chooseCity:) type:2];
    [self tableView];
    self.isRefresh = NO;//默认是上拉加载
    page = 1;
//    [self loadDataWithCityName:self.left.text page:[NSString stringWithFormat:@"%ld",page]];
}

-(void)loadDataWithCityName:(NSString*)cityName page:(NSString*)page{
    [self showLoadingAnimation];
    WS(weakSelf);
    [[GroupBuyingReqeust shareInstance] groupBuyingSearchWithCityName:cityName page:page sucess:^(NSMutableArray *dataSource) {
        [weakSelf performOnMainThread:^{
            [weakSelf stopLoadingAnimation];
            if (self.isRefresh) {
                [self.dataSource removeAllObjects];
            }
            [weakSelf.dataSource addObjectsFromArray:dataSource];
            [weakSelf.tableView reloadData];
            //停止加载
            [self tableViewStopLodingMore:weakSelf.tableView dataSource:weakSelf.dataSource];
            //停止刷新
            [self tableViewStopRefresh:self.tableView];
        } wait:NO];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavItemWithImage:@"ios7_top_navigation_locationicon" target:self action:@selector(locationCityGroupBuy:) type:2];
}

#pragma mark - 条目按钮
-(void)locationCityGroupBuy:(UIGestureRecognizer*)sender{
    ShowGDMap* map = [[ShowGDMap alloc] init];
    map.city = self.left.text;
    [self pushVc:map];
}

-(void)chooseCity:(UIGestureRecognizer*)sender{
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    WS(weakSelf);
    [cityViewController choseCityBlock:^(NSString *cityName) {
        [weakSelf performOnMainThread:^{
            weakSelf.left.text = [cityName substringToIndex:cityName.length - 1];
        } wait:NO];
    }];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentVc:navigationController];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupBuyinyRecommondCell* recommondCell = [GroupBuyinyRecommondCell cellWithTableView:tableView];
    recommondCell.modelSource = self.dataSource[indexPath.row];
    return recommondCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        GroupBuyingHeadView* head = [[GroupBuyingHeadView alloc] init];
        head.deleagte = self;
        return head;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return (SCREENWIDTH - 10*5)/4 + 30;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommondDetailVC* detail = [[RecommondDetailVC alloc] init];
    detail.dataSource = self.dataSource[indexPath.row];
    [self pushVc:detail];
}

#pragma mark - GroupBuyingHeadViewDeleagte
-(void)chooseSearchCategory:(NSUInteger)tag{
    if (tag == 1) {
        HotelVC* hotel = [[HotelVC alloc]init];
        hotel.cityName = self.left.text;
        [self pushVc:hotel];
    }
    
    if (tag == 2) {
        ScenicAreaVC* scenic = [[ScenicAreaVC alloc] init];
        scenic.cityName = self.left.text;
        [self pushVc:scenic];
    }
    
    if (tag == 3) {
        MovieVC* movie = [[MovieVC alloc]init];
        movie.cityName = self.left.text;
        [self pushVc:movie];
    }
}

#pragma mark - 懒加载
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.1)];
        _tableView.tableHeaderView = view;
        [self tabelVewRefresh:_tableView actionBlock:^{
            page = 1;
            self.isRefresh = YES;
            [self loadDataWithCityName:self.left.text page:[NSString stringWithFormat:@"%ld",(long)page]];
        }];
        [self tableViewLoadingMore:_tableView actionBlock:^{
            self.isRefresh = NO;
            page++;
            [self loadDataWithCityName:self.left.text page:[NSString stringWithFormat:@"%ld",(long)page]];
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
