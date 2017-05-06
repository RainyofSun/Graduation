//
//  DreamVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "DreamVC.h"
#import "WBIntroduceFile.h"
#import "WeatherRequest.h"
#import "WBBaseTableView.h"
#import "WeatherDetailCell.h"
#import "WeatherDetailHeadView.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

@interface DreamVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WBBaseTableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,strong)WeatherDetailHeadView* detaileHead;
//城市定位管理器
@property(nonatomic,strong)JFLocation* locationManager;
//城市数据管理器
@property(nonatomic,strong)JFAreaDataManager* cityDataManager;

@end

@implementation DreamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气查询";
    self.locationManager = [[JFLocation alloc] init];
    [self tableView];
    [self getDataWithDict:[WBUSERDEFAULT objectForKey:@"locaton"]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavItemWithImage:@"ios7_top_navigation_locationicon" target:self action:@selector(locationCity:) type:1];
}

#pragma mark - 获取天气信息
-(void)getDataWithDict:(NSDictionary*)dict{
    WS(weakSelf);
    [[WeatherRequest shareInstance] weatherQueryWithLon:dict[@"lon"] lat:dict[@"lat"] sucess:^(NSDictionary *today, NSDictionary *now, NSMutableArray *future) {
        [weakSelf performOnMainThread:^{
            weakSelf.detaileHead.dataSource = [WeatherTodayModel modelWithDictionary:today];
            [weakSelf.dataSource addObjectsFromArray:future];
            [weakSelf.tableView reloadData];
        } wait:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherDetailCell* cell = [WeatherDetailCell cellWithTableView:tableView];
    cell.futureModel = self.dataSource[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.detaileHead = [WeatherDetailHeadView headerFooterViewWithTableView:tableView];
        return self.detaileHead;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 250;
}

#pragma mark - NavItem点击方法
-(void)locationCity:(UIGestureRecognizer*)sender{
    JFCityViewController* cityVC = [[JFCityViewController alloc] init];
    WS(weakSelf);
    [cityVC choseCityBlock:^(NSString *cityName) {
#if 0
        [[WBLocationManager shareInstance] getLocationFormCityName:cityName];
        NSLog(@"坐标%@%@",[WBUSERDEFAULT objectForKey:@"lon"],[WBUSERDEFAULT objectForKey:@"lat"]);
#elif 1
        [weakSelf performOnMainThread:^{
            CLGeocoder* geocoder = [[CLGeocoder alloc] init];
            __block NSString* lon = [NSString new];
            __block NSString* lat = [NSString new];
            [geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                if ([placemarks count] > 0 && error == nil) {
                    CLPlacemark* placePark = [placemarks objectAtIndex:0];
                    lon = [NSString stringWithFormat:@"%f",placePark.location.coordinate.longitude];
                    lat = [NSString stringWithFormat:@"%f",placePark.location.coordinate.latitude];
                    [weakSelf getDataWithDict:@{@"lon":lon,@"lat":lat}];
                    [WBUSERDEFAULT setObject:@{@"lon":lon,@"lat":lat} forKey:@"weatherDetail"];
                    [WBUSERDEFAULT setObject:cityName forKey:@"locationCity"];
                    [WBUSERDEFAULT setObject:cityName forKey:@"currentCity"];
                    [self.cityDataManager cityNumberWithCity:cityName cityNumber:^(NSString *cityNumber) {
                        [WBUSERDEFAULT setObject:cityNumber forKey:@"cityNumber"];
                    }];
                }else if ([placemarks count] == 0 && error == nil){
                    [SVProgressHUD showErrorWithStatus:@"没有找到坐标"];
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                }else if (error != nil){
                    NSLog(@"%@",error);
                }
            }];
        } wait:NO];
#endif
    }];
    UINavigationController* navC = [[UINavigationController alloc] initWithRootViewController:cityVC];
    navC.title = @"城市";
    [self presentVc:navC];
}

#pragma mark - 懒加载
-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self.view);
        }];
        //设置背景图片
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:_tableView.bounds];
        [backImageView setImage:[UIImage imageNamed:@"weather.jpg"]];
        _tableView.backgroundView=backImageView;
        //UITableView的group样式下顶部空白的处理
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(JFAreaDataManager *)cityDataManager{
    if (!_cityDataManager) {
        _cityDataManager = [JFAreaDataManager shareManager];
        [_cityDataManager areaSqliteDBData];
    }
    return _cityDataManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
