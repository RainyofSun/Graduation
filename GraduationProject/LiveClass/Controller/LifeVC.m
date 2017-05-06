//
//  LifeVC.m
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "LifeVC.h"
#import "WBBaseTableView.h"
#import "LifeCell.h"
#import "WBIntroduceFile.h"
#import "VCClass.h"
#import "WeatherHeadView.h"
#import "WeatherRequest.h"
#import "WBLocationManager.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import "WeatherTodayModel.h"

@interface LifeVC ()<UITableViewDelegate,UITableViewDataSource,LifeCellDelegate,WeatherHeadViewDelegate>

//组头标题
@property(nonatomic,strong)NSArray* groupTitle;
//tablevView数组
@property(nonatomic,strong)NSArray* tableData;
@property(nonatomic,strong)WBBaseTableView* tableView;
//tableView头视图
@property(nonatomic,strong)WeatherHeadView* head;
//城市定位管理器
@property(nonatomic,strong)JFLocation* locationManager;
//城市数据管理器
@property(nonatomic,strong)JFAreaDataManager* cityDataManager;
//今日的天气
@property(nonatomic,strong)NSDictionary* todayModel;

@end

@implementation LifeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[JFLocation alloc] init];
    self.groupTitle = @[@"生活查询",@"天气质量",@"电视节目"];
    self.tableData = @[
                       @{@"data":@[
                                 @{@"image":@"oil_p.jpg",@"title":@"今日油价"},
                                 @{@"image":@"express_search.jpg",@"title":@"快递查询"}]},
                       @{@"data":@[
                                 @{@"image":@"air_q.jpg",@"title":@"空气质量"},
                                 @{@"image":@"weather_q.jpg",@"title":@"天气查询"}]},
                       @{@"data":@[
                                 @{@"image":@"tv_showList.jpg",@"title":@"电视节目单"}]}];
//    self.tableData = @[
//                       @{@"data":@[
//                                 @{@"image":@"head",@"title":@"身份证查询"},
//                                 @{@"image":@"Phone",@"title":@"手机归属地"},
//                                 @{@"image":@"Ecology_Oil",@"title":@"今日油价"},
//                                 @{@"image":@"aim_express",@"title":@"快递查询"}]},
//                       @{@"data":@[
//                                 @{@"image":@"air_element",@"title":@"空气质量"},
//                                 @{@"image":@"query_search_weather",@"title":@"天气查询"}]},
//                       @{@"data":@[
//                                 @{@"image":@"tv_television",@"title":@"电视节目单"}]}];
    [self tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightNavItemWithImage:@"ios7_top_navigation_locationicon" target:self action:@selector(locationCity:) type:2];
    //判断详情里边有没有储存城市坐标
    NSDictionary* dict = [WBUSERDEFAULT objectForKey:@"weatherDetail"];
    if (dict) {
        [self getWeatherTodayWithLon:dict[@"lon"] lat:dict[@"lat"]];
    }
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
                    [weakSelf getWeatherTodayWithLon:lon lat:lat];
                    [WBUSERDEFAULT setObject:@{@"lon":lon,@"lat":lat} forKey:@"locaton"];
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

#pragma mark - 获取当日的天气
-(void)getWeatherTodayWithLon:(NSString*)lon lat:(NSString*)lat{
//    WS(weakSelf);
//    [[WeatherRequest shareInstance] weatherQueryWithLon:lon lat:lat sucess:^(NSDictionary *today, NSDictionary *now, NSMutableArray *future) {
//        [weakSelf performOnMainThread:^{
//            self.todayModel = today;
//            self.head.dataSource = [WeatherTodayModel modelWithDictionary:today];
//        } wait:NO];
//    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LifeCell* cell = [LifeCell cellWithTableView:tableView];
    cell.delegate = self;
    [cell setData:self.tableData[indexPath.section][@"data"]];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.groupTitle[section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.head = [WeatherHeadView headerFooterViewWithTableView:tableView];
        self.head.delegate = self;
        return self.head;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 180;
    }
    return 0;
}

#pragma mark - JFLocationDelegate
//定位成功
-(void)currentLocation:(NSDictionary *)locationDictionary{
    NSString* city = [locationDictionary valueForKey:@"City"];
    WS(weakSelf);
    if (![self.head.cityName.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#if 0
            NSDictionary*dict = [[WBLocationManager shareInstance] getLocationFormCityName:city];
            NSLog(@"坐标%@",dict);
#elif 1
            CLGeocoder* geocoder = [[CLGeocoder alloc] init];
            __block NSString* lon = [NSString new];
            __block NSString* lat = [NSString new];
            [geocoder geocodeAddressString:city completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                if ([placemarks count] > 0 && error == nil) {
                    CLPlacemark* placePark = [placemarks objectAtIndex:0];
                    lon = [NSString stringWithFormat:@"%f",placePark.location.coordinate.longitude];
                    lat = [NSString stringWithFormat:@"%f",placePark.location.coordinate.latitude];
                    [weakSelf getWeatherTodayWithLon:lon lat:lat];
                    [WBUSERDEFAULT setObject:@{@"lon":lon,@"lat":lat} forKey:@"locaton"];
                    [WBUSERDEFAULT setObject:city forKey:@"locationCity"];
                    [WBUSERDEFAULT setObject:city forKey:@"currentCity"];
                    [self.cityDataManager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                        [WBUSERDEFAULT setObject:cityNumber forKey:@"cityNumber"];
                    }];
                }else if ([placemarks count] == 0 && error == nil){
                    [SVProgressHUD showErrorWithStatus:@"没有找到坐标"];
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                }else if (error != nil){
                    NSLog(@"%@",error);
                }
            }];
#endif
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentVc:alertController];
    }
}

#pragma mark - WeatherHeadViewDelegate
-(void)weatherDetail:(id)sender{
    [self pushVc:[[DreamVC alloc] init]];
}

#pragma mark - LifeCellDelegate
-(void)pushDetailVC:(NSString*)title{
    if ([title isEqualToString:@"身份证查询"]) {
        [self pushVc:[[IDCardVC alloc] init]];
    }
    
    if ([title isEqualToString:@"手机归属地"]) {
        [self pushVc:[[PhoneNumVC alloc] init]];
    }
    
    if ([title isEqualToString:@"今日油价"]) {
        [self pushVc:[[CurrencyVC alloc] init]];
    }
    
    if ([title isEqualToString:@"快递查询"]) {
        [self pushVc:[[ExpressVC alloc] init]];
    }
    
    if ([title isEqualToString:@"天气查询"]) {
        [self pushVc:[[DreamVC alloc] init]];
    }
    
    if ([title isEqualToString:@"空气质量"]) {
        [self pushVc:[[IPAdressVC alloc] init]];
    }
    
    if ([title isEqualToString:@"电视节目单"]) {
        [self pushVc:[[HousingLoanVC alloc] init]];
    }
}

#pragma mark - 懒加载
-(WBBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WBBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-kBottomBarHeight);
            make.top.equalTo(self.view.mas_top).with.offset(-35);
        }];
    }
    return _tableView;
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
