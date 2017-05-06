//
//  AppDelegate+DelegateRootVC.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "AppDelegate+DelegateRootVC.h"
#import "WBIntroduceFile.h"

@interface AppDelegate ()<RDVTabBarControllerDelegate,UIScrollViewDelegate>

@end

@implementation AppDelegate (DelegateRootVC)

-(void)setRootViewController{
    if ([WBUSERDEFAULT objectForKey:WB_FIRST_USE]) {
        //不是第一次安装
        [self setTabbarController];
    }else{
        UIViewController* emptyViewController = [[UIViewController alloc] init];
        self.window.rootViewController = emptyViewController;
        [self createLoadingScrollView];
    }
}

-(void)setRootWithTabBarController:(RDVTabBarController*)controller{
    UINavigationController* navc = [[UINavigationController alloc] initWithRootViewController:controller];
    navc.navigationBar.barTintColor = BLUE;
    [navc.navigationBar setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:WHITE}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:SETFONTSIZE(19),NSForegroundColorAttributeName:WHITE}];
    navc.navigationBar.tintColor = WHITE;
    self.window.rootViewController = navc;
}

#pragma mark - 设置界面
-(void)setTabbarController{
    PayFeeVC* fee = [[PayFeeVC alloc] init];
    LifeVC* life = [[LifeVC alloc] init];
    NewsVC* news = [[NewsVC alloc] init];
    GroupBuyingVC* groupBuying = [[GroupBuyingVC alloc] init];
//    MoreThingVC* more = [[MoreThingVC alloc] init];
    RDVTabBarController* tableController = [[RDVTabBarController alloc] init];
    [tableController setViewControllers:@[life,fee,news,groupBuying]];
    [self setRootWithTabBarController:tableController];
    tableController.delegate = self;
    [self customizeTabBarForController:tableController type:1];
}

-(void)customizeTabBarForController:(RDVTabBarController*)tabbarController type:(NSInteger)type{
    UIImage* finishedImage = [VTGeneralTool createImageWithColor:WHITE];
    UIImage* unfinishedImage = [VTGeneralTool createImageWithColor:WHITE];
    NSArray* tabBarItemImages = @[@"tabbar_home_os7",@"tabbar_discover_os7",@"tabbar_message_center_os7",@"navigationbar_more_os7"];
    NSArray* selectedImages = @[@"tabbar_home_selected_os7",@"tabbar_discover_selected_os7",@"tabbar_message_center_selected_os7",@"navigationbar_more_highlighted_os7"];
    NSArray* tabBarItems = @[@"查询",@"缴费",@"资讯",@"团购"];
    NSInteger index = 0;
    [[tabbarController tabBar] setTranslucent:YES];//设置tabbar的透明度
    for (RDVTabBarItem* item in [[tabbarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage* selectImage = [UIImage imageNamed:[selectedImages objectAtIndex:index]];
        UIImage* unselectImage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        [item setFinishedSelectedImage:selectImage withFinishedUnselectedImage:unselectImage];
        NSDictionary* unselectArr = @{NSFontAttributeName : SETFONTSIZE(11),
                                      NSForegroundColorAttributeName : BLACK};
        NSDictionary* selectArr = @{NSFontAttributeName : SETFONTSIZE(11),
                                    NSForegroundColorAttributeName : ORANGE};
        [item setUnselectedTitleAttributes:unselectArr];
        [item setSelectedTitleAttributes:selectArr];
        [item setTitle:tabBarItems[index]];
        index ++;
    }
}

-(void)setAppWindows{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = WHITE;
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : WHITE}];
}

#pragma mark - 引导页
-(void)createLoadingScrollView{
    UIScrollView* sc = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray* arr = @[@"1.jpg",@"2.jpg",@"3",@"4",@"5"];
    for (int i = 0; i < arr.count; i++) {
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, SCREENHEIGHT)];
        img.image = CONTENTFILEIMAGE(arr[i]);
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
        if (i == arr.count - 1) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((self.window.frame.size.width/2)-50, SCREENHEIGHT - 110, 100, 40);
            btn.backgroundColor = CYANINE;
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:WHITE forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = WHITE.CGColor;
        }
        sc.contentSize = CGSizeMake(SCREENWIDTH*arr.count, self.window.bounds.size.height);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > SCREENWIDTH* 4 + 30) {
        [self goToMain];
    }
}

-(void)goToMain{
    [WBUSERDEFAULT setObject:@"isone" forKey:WB_FIRST_USE];
    [WBUSERDEFAULT synchronize];
    [self setTabbarController];
}

@end
