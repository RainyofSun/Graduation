//
//  BaseVC.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseVC.h"
#import "WBIntroduceFile.h"
#import "AppDelegate.h"

@interface BaseVC ()

@property(nonatomic,strong)RTSpinKitView* spinView;

@end

@implementation BaseVC

#pragma mark - VC.lifeCircle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self rdv_tabBarController].navigationItem.titleView = nil;
    if ([self isKindOfClass:[LifeVC class]] ||
        [self isKindOfClass:[NewsVC class]] ||
        [self isKindOfClass:[GroupBuyingVC class]] ||
        [self isKindOfClass:[PayFeeVC class]]) {
        [self messageBar];
    } else{
        [self rdv_tabBarController].navigationItem.rightBarButtonItem = nil;
        [self rdv_tabBarController].navigationItem.leftBarButtonItem = nil;
    }
    [self rdv_tabBarController].navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : WHITE}];
    if (self.rdv_tabBarController.isTabBarHidden == self.isShowTabbar) {
        //返回正常的tabbar
        [self.rdv_tabBarController setTabBarHidden:!self.isShowTabbar];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE;
    self.isShowTabbar = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : SETFONTSIZE(19),NSForegroundColorAttributeName : WHITE}];
    self.navigationController.navigationBar.tintColor = WHITE;
    [self setUpNav];
    [self createNavBar];
}

#pragma mark - 通知使用的方法
-(void)initStatusBar{
    
}

-(void)showStatusBarWithTitle:(NSString *)title{
    
}

-(void)changeStatusBarTitle:(NSString *)title{
    
}

-(void)hiddenStatusBar{
    
}

#pragma mark - Navgationitem.set

-(void)NavItemSet{
    
}

-(void)messageBar{
    if ([self isKindOfClass:[PayFeeVC class]]) {
        [self rdv_tabBarController].navigationItem.title = @"缴费";
    }
    if ([self isKindOfClass:[LifeVC class]]) {
        [self rdv_tabBarController].navigationItem.title = @"生活";
    }
    if ([self isKindOfClass:[NewsVC class]]){
        [self rdv_tabBarController].navigationItem.title = @"新闻头条";
    }
    if ([self isKindOfClass:[GroupBuyingVC class]]) {
        [self rdv_tabBarController].navigationItem.title = @"团购";
    }
//    if ([self isKindOfClass:[MoreThingVC class]]) {
//        [self rdv_tabBarController].navigationItem.title = @"更多";
//    }
}

-(void)setUpNav{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    [self messageBar];
}

-(void)createNavBar{
    self.view.backgroundColor = WHITE;
}

#pragma mark - 设置左右item
-(void)setLeftNavItemWitnImage:(NSString *)imageName target:(id)target action:(SEL)action type:(NSInteger)type{
    UIImageView* left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [left setTapTarget:target action:action];
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc] initWithCustomView:left];
    if (type == 1) {
        self.navigationItem.leftBarButtonItem = leftBar;
    }else{
        [self rdv_tabBarController].navigationItem.leftBarButtonItem = leftBar;
    }
}

-(void)setRightNavItemWithImage:(NSString *)imageName target:(id)target action:(SEL)action type:(NSInteger)type{
    UIImageView* right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [right setTapTarget:target action:action];
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc] initWithCustomView:right];
    if (type == 1) {
        self.navigationItem.rightBarButtonItem = rightBar;
    }else{
        [self rdv_tabBarController].navigationItem.rightBarButtonItem = rightBar;
    }
    
}

-(void)setLeftNavItemWithTitle:(NSString *)title target:(id)target action:(SEL)action type:(NSInteger)type{
    self.left = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    self.left.userInteractionEnabled = YES;
    self.left.text = title;
    [self.left setTapTarget:target action:action];
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc] initWithCustomView:self.left];
    if (type == 1) {
        self.navigationItem.leftBarButtonItem = leftBar;
    }else{
        [self rdv_tabBarController].navigationItem.leftBarButtonItem = leftBar;
    }
}

-(void)tabelVewRefresh:(WBBaseTableView *)tableView actionBlock:(RefreshLoadMoreHandle)actionBlock{
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:actionBlock];
    [header setTitle:@"正在更新..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = BLACK;
    header.lastUpdatedTimeLabel.hidden = NO;
    tableView.mj_header = header;
}

-(void)tableViewStopRefresh:(WBBaseTableView *)tableView{
    [tableView.mj_header endRefreshing];
}

-(void)tableViewLoadingMore:(WBBaseTableView *)tableView actionBlock:(RefreshLoadMoreHandle)actionBlock{
    MJRefreshBackStateFooter* footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:actionBlock];
    [footer setTitle:@"上拉加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"松开即可刷新..." forState:MJRefreshStatePulling];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    footer.automaticallyChangeAlpha = YES;
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = BLACK;
    tableView.mj_footer = footer;
}

-(void)tableViewStopLodingMore:(WBBaseTableView *)tableView dataSource:(NSMutableArray *)dataSource{
    [tableView.mj_footer endRefreshing];
    if (dataSource.count == 0) {
        [SVProgressHUD showWithStatus:@"数据加载完毕..."];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }
}

#pragma mark - collectionView的下拉刷新
-(void)collectionViewRefresh:(UICollectionView *)collectionView actionBlock:(RefreshLoadMoreHandle)actionBlock{
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:actionBlock];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = BLACK;
    header.lastUpdatedTimeLabel.hidden = NO;
    collectionView.mj_header = header;
}

-(void)collectionViewStopRefresh:(UICollectionView *)collectionView{
    [collectionView.mj_header endRefreshing];
}

-(void)collectionViewLodingMore:(UICollectionView *)collectionView sctionBlock:(RefreshLoadMoreHandle)actionBlock{
    MJRefreshBackStateFooter* footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:actionBlock];
    [footer setTitle:@"上拉加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    footer.automaticallyChangeAlpha = YES;
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = BLACK;
    collectionView.mj_footer = footer;
}

-(void)collectionViewStopLoadingMore:(UICollectionView *)collectionView dataCount:(NSMutableArray *)dataCount{
    [collectionView.mj_footer endRefreshing];
    //提示没有更多数据了
    if (dataCount.count == 0) {
        [SVProgressHUD showWithStatus:@"数据加载完毕..."];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        return;
    }
}

//展示没有数据的界面
-(void)showNoDataImage{
    
}
//移除没有数据的界面
-(void)removeNodataImage{
    
}
//提示是否需要登录
-(void)showShouldLoginPoint{
    
}

//分享URL
-(void)shareUrl:(NSString *)url title:(NSString *)title{
    
}

-(void)goToLogin{
//    WBLoginVC* login = [[WBLoginVC alloc] init];
//    [[AppDelegate rootNavigationController] pushViewController:login animated:YES];
}

-(void)showLoadingAnimation{
    RTSpinKitView* spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyle9CubeGrid color:ARCDOMCOLOR spinnerSize:60];
    [self.view addSubview:spinner];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [spinner startAnimating];
    self.spinView = spinner;
}

-(void)stopLoadingAnimation{
    [self.spinView stopAnimating];
    [self.spinView removeFromSuperview];
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

-(BOOL)isNetworkReachable{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
