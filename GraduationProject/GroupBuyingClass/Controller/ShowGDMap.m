//
//  ShowGDMap.m
//  GraduationProject
//
//  Created by MS on 17/3/19.
//  Copyright © 2017年 LR. All rights reserved.
//添加更改地图类型的按钮，是否显示交通路线的按钮

#import "ShowGDMap.h"
#import "WBIntroduceFile.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MANaviRoute.h"
#import "POIAnnotation.h"
#import "WBLocationManager.h"

#define kStartTitle     @"起点"
#define kEndTitle       @"终点"
static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface ShowGDMap ()<MAMapViewDelegate,UISearchBarDelegate,AMapSearchDelegate>

@property(nonatomic,strong)MAMapView *mapView;
//截屏按钮
@property(nonatomic,strong)UIButton* shotScreen;
//是否显示交通
@property(nonatomic,strong)UIButton* traffic;
//是否显示卫星视图
@property(nonatomic,strong)UIButton* sliteMap;
@property(nonatomic,strong)UISearchBar* searchAddress;
//地图搜索类
@property(nonatomic,strong)AMapSearchAPI* search;
//地图标注数据源->大头针
@property(nonatomic,strong)NSMutableArray *poiAnnotations;
//地图标注数据源->点击大头针展示的文字
@property(nonatomic,strong)NSMutableArray* titleArray;
//点击大头针展示的label
@property(nonatomic,strong)UILabel* animationTitle;
@property(nonatomic,copy)NSString* animationName;
//点击大头针展示的label
@property(nonatomic,strong)UILabel* animationGo;
/* 路径规划类型 */
@property (nonatomic, strong) AMapRoute *route;
/* 起始点经纬度. */
@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic, assign) CLLocationCoordinate2D destinationCoordinate;
@property (nonatomic, assign) NSInteger shareRouteType;
/* 用于显示当前路线方案. */
@property (nonatomic, strong) MANaviRoute *naviRoute;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;

@end

@implementation ShowGDMap

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchAddress];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    //后台定位
    self.mapView.pausesLocationUpdatesAutomatically = NO;
    self.mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
//    self.mapView.zoomEnabled = YES;    //NO表示禁用缩放手势，YES表示开启
//    [self.mapView setZoomLevel:17.5 animated:YES];//设置地图的缩放级别
//    self.mapView.scrollEnabled = NO;    //NO表示禁用滑动手势，YES表示开启
    self.shareRouteType = 0;
    self.startCoordinate        = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    self.destinationCoordinate  = CLLocationCoordinate2DMake([self.location[@"lat"] floatValue], [self.location[@"lon"] floatValue]);
    [self addDefaultAnnotations];
    [self shotScreen];
    [self traffic];
    [self sliteMap];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    if (self.location) {
       pointAnnotation.coordinate = CLLocationCoordinate2DMake([self.location[@"lon"] floatValue], [self.location[@"lat"] floatValue]);
    }
    
    if (self.storeName) {
        pointAnnotation.title = self.storeName;
    }
    
    if (self.storeAddress) {
        pointAnnotation.subtitle = self.storeAddress;
    }
    
    [self.mapView addAnnotation:pointAnnotation];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CLLocation* location = [[CLLocation alloc] initWithLatitude:point.x longitude:point.y];
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}

- (void)addDefaultAnnotations{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    self.destinationAnnotation = destinationAnnotation;
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
}

#pragma mark - 保存图盘到相册
-(void)saveImage:(UIButton*)sender{
    UIImage* shotImage = [self.mapView takeSnapshotInRect:self.view.bounds];
    UIImageWriteToSavedPhotosAlbum(shotImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"成功保存到相册"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }else {
        [SVProgressHUD showErrorWithStatus:@"图片保存出错,请重试"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }
}
#pragma mark - 是否显示交通
-(void)traffic:(UIButton*)sender{
    if (sender.selected) {
        self.mapView.showTraffic = YES;
    }else{
        self.mapView.showTraffic = NO;
    }
    sender.selected = !sender.selected;
}

#pragma mark - 是否显示卫星视图
-(void)sliteMap:(UIButton*)sender{
    if (sender.selected) {
        //设置底图种类为卫星图
        [self.mapView setMapType:MAMapTypeSatellite];
    }else{
        [self.mapView setMapType:MAMapTypeStandard];
    }
    sender.selected = !sender.selected;
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self startSearch:searchBar.text];
    [searchBar resignFirstResponder];
}

#pragma mark - 发起搜索
-(void)startSearch:(NSString*)searchClass{
    AMapPOIKeywordsSearchRequest* reqeust = [[AMapPOIKeywordsSearchRequest alloc] init];
    reqeust.keywords = searchClass;
    reqeust.requireExtension = YES;
    if (self.city) {
        reqeust.city = self.city;
    }else{
        reqeust.city = [WBUSERDEFAULT objectForKey:@"currentCity"];
    }
    
    /*
     只搜索本城市的POI
     request.cityLimit           = YES;
     request.requireSubPOIs      = YES;
     */
    [self.search AMapPOIKeywordsSearch:reqeust];
}

#pragma mark -  规划路线
-(void)planningRoute:(UIGestureRecognizer*)sender{
    [self shareAction];
}

- (void)shareAction{
    self.startAnnotation.coordinate = self.startCoordinate;
    self.destinationAnnotation.coordinate = self.destinationCoordinate;
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.waypoints = @[[AMapGeoPoint locationWithLatitude:45.780563 longitude:126.651764]];
    navi.requireExtension = YES;
    //    navi.strategy = 5;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                           longitude:self.startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                longitude:self.destinationCoordinate.longitude];
    
    [self.search AMapDrivingRouteSearch:navi];
}

#pragma mark - AMapSearchDelegate
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    WS(weakSelf);
    if (response.pois.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"暂无结果"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2.0 completion:^{
            [weakSelf.searchAddress setText:@""];
        }];
        return;
    }
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        [self.titleArray addObject:obj.name];
        [self.poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
    }];
    
    /* 将结果以annotation的形式加载到地图上 */
    [self.mapView addAnnotations:self.poiAnnotations];
    /* 如果只有一个结果，设置其为中心点 */
    if (self.poiAnnotations.count == 1){
        [self.mapView setCenterCoordinate:[self.poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else{
        [self.mapView showAnnotations:self.poiAnnotations animated:NO];
    }
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;
        
        if ([annotation isKindOfClass:[MANaviAnnotation class]])
        {
            switch (((MANaviAnnotation*)annotation).type)
            {
                case MANaviAnnotationTypeRailway:
                    poiAnnotationView.image = [UIImage imageNamed:@"railway_station"];
                    break;
                    
                case MANaviAnnotationTypeBus:
                    poiAnnotationView.image = [UIImage imageNamed:@"bus"];
                    break;
                    
                case MANaviAnnotationTypeDrive:
                    poiAnnotationView.image = [UIImage imageNamed:@"car"];
                    break;
                    
                case MANaviAnnotationTypeWalking:
                    poiAnnotationView.image = [UIImage imageNamed:@"man"];
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            /* 起点. */
            if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
            }
            /* 终点. */
            else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
            }
            
        }
        return poiAnnotationView;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    view.backgroundColor = [UIColor whiteColor];
    self.animationTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)/2)];
    self.animationTitle.text = self.animationName;
    self.animationTitle.numberOfLines = 0;
    self.animationTitle.font = [UIFont systemFontOfSize:10];
    [view addSubview:self.animationTitle];
    self.animationGo = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.bounds)/2, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)/2)];
    self.animationGo.text = @"到这里";
    [self.animationGo setFont:[UIFont boldSystemFontOfSize:14]];
    self.animationGo.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.animationGo];
    [view setTapTarget:self action:@selector(planningRoute:)];
}

-(void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    view.backgroundColor = [UIColor clearColor];
    [self.animationTitle removeFromSuperview];
    [self.animationGo removeFromSuperview];
}

///当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标，示例代码如下：
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

///定位失败后会回调这个函数
-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    if (error) {
        WS(weakSelf);
        NSLog(@"定位失败%@",error.localizedDescription);
        [SVProgressHUD showErrorWithStatus:@"定位失败,正在重新定位..."];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:2 completion:^{
            [[WBLocationManager shareInstance] startLocation];
            [weakSelf performAfter:2 block:^{
                [[WBLocationManager shareInstance] endLocation];
            }];
        }];
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[LineDashPolyline class]]){
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDashPattern = @[@10, @15];
        polylineRenderer.strokeColor = [UIColor redColor];
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]]){
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        polylineRenderer.lineWidth = 8;
        if (naviPolyline.type == MANaviAnnotationTypeWalking){
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }else if (naviPolyline.type == MANaviAnnotationTypeRailway){
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }else{
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]]){
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:(MAMultiPolyline*)overlay];
        polylineRenderer.lineWidth = 8;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        return polylineRenderer;
    }
    return nil;
}

-(void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    if (response.route == nil) {
        return;
    }
    self.route = response.route;
    if (response.count > 0){
        [self presentCurrentCourse];
    }
}

/* 展示当前路线方案. */
- (void)presentCurrentCourse{
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView showOverlays:self.naviRoute.routePolylines edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge) animated:YES];
}

/* 清空地图上已有的路线. */
- (void)clear{
    [self.naviRoute removeFromMapView];
}

//设置折线的样式
//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
//    if ([overlay isKindOfClass:[MAPolyline class]]) {
//        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
//        
//        polylineRenderer.lineWidth    = 8.f;
//        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
////        polylineRenderer.lineJoin = kCALineJoinRound;
////        polylineRenderer.lineCapType  = kCALineCapRound;
//        
//        return polylineRenderer;
//    }
//    
//    return nil;
//}

#pragma mark - 懒加载
-(UIButton *)shotScreen{
    if (!_shotScreen) {
        _shotScreen = [UIButton buttonWithType:UIButtonTypeCustom];
        _shotScreen.frame = CGRectMake(SCREENWIDTH - 42, 60, 36, 36);
        [_shotScreen setImage:[UIImage imageNamed:@"cut"] forState:UIControlStateNormal];
        [_shotScreen addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_shotScreen];
    }
    return _shotScreen;
}

-(UIButton *)traffic{
    if (!_traffic) {
        _traffic = [UIButton buttonWithType:UIButtonTypeCustom];
        _traffic.frame = CGRectMake(SCREENWIDTH - 38, 106, 30, 40);
        [_traffic setImage:[UIImage imageNamed:@"lights_traffic"] forState:UIControlStateNormal];
        [_traffic addTarget:self action:@selector(traffic:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_traffic];
    }
    return _traffic;
}

-(UIButton *)sliteMap{
    if (!_sliteMap) {
        _sliteMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sliteMap setImage:[UIImage imageNamed:@"satellite"] forState:UIControlStateNormal];
        _sliteMap.frame = CGRectMake(SCREENWIDTH - 42, 156, 36, 36);
        [_sliteMap addTarget:self action:@selector(sliteMap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_sliteMap];
    }
    return _sliteMap;
}

-(UISearchBar *)searchAddress{
    if (!_searchAddress) {
        _searchAddress = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _searchAddress.placeholder = @"请输入搜索词";
        _searchAddress.delegate = self;
        self.navigationItem.titleView = _searchAddress;
    }
    return _searchAddress;
}

-(NSMutableArray *)poiAnnotations{
    if (!_poiAnnotations) {
        _poiAnnotations = [NSMutableArray array];
    }
    return _poiAnnotations;
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
