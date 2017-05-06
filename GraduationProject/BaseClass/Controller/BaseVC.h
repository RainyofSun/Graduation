//
//  BaseVC.h
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
/*
 baseVC之后建立的VC都继承此VC
 */

#import <UIKit/UIKit.h>
#import "WBBaseTableView.h"

typedef void (^RefreshLoadMoreHandle)(void);
@interface BaseVC : UIViewController

/**
 * 网络是否可用
 */
@property(nonatomic,assign)BOOL isNetworkReachable;
/**
 * 是否显示tabbar
 */
@property(nonatomic,assign)Boolean isShowTabbar;
/**
 * 显示没有数据的界面
 */
-(void)showNoDataImage;
/**
 * 移除无数据界面
 */
-(void)removeNodataImage;
/**
 * 需要登录
 */
-(void)showShouldLoginPoint;
/**
 * 加载视图
 */
-(void)showLoadingAnimation;
/**
 * 停止加载
 */
-(void)stopLoadingAnimation;
/**
 * 分享页面
 * @param url url
 * @param title 标题
 */
-(void)shareUrl:(NSString*)url title:(NSString*)title;

-(void)goToLogin;
-(void)createNavBar;
/**
 * 根据图片设置左NavItem
 * @param imageName 图片名字
 * @param type      是不是1级界面
 */
-(void)setLeftNavItemWitnImage:(NSString*)imageName target:(id)target action:(SEL)action type:(NSInteger)type;
/**
 * 根据图片设置右NavItem
 * @param imageName 图片名字
 * @param type      是不是1级界面
 */
-(void)setRightNavItemWithImage:(NSString*)imageName target:(id)target action:(SEL)action type:(NSInteger)type;
/**
 * 根据名字设置左条目
 * @param title     名称
 * @param type      是不是1级界面
 */
-(void)setLeftNavItemWithTitle:(NSString*)title target:(id)target action:(SEL)action  type:(NSInteger)type;
@property(nonatomic,strong)UILabel* left;
/**
 * 状态栏
 */
-(void)initStatusBar;
-(void)showStatusBarWithTitle:(NSString*)title;
-(void)changeStatusBarTitle:(NSString*)title;
-(void)hiddenStatusBar;

/**
 * 下拉刷新
 */
-(void)tabelVewRefresh:(WBBaseTableView*)tableView actionBlock:(RefreshLoadMoreHandle)actionBlock;
/**
 * 停止刷新
 */
-(void)tableViewStopRefresh:(WBBaseTableView*)tableView;
/**
 * 上拉加载
 */
-(void)tableViewLoadingMore:(WBBaseTableView*)tableView actionBlock:(RefreshLoadMoreHandle)actionBlock;
/**
 * 上拉停止加载
 */
-(void)tableViewStopLodingMore:(WBBaseTableView*)tableView dataSource:(NSMutableArray*)dataSource;
/** 
 * collectionView下拉刷新
 */
-(void)collectionViewRefresh:(UICollectionView*)collectionView actionBlock:(RefreshLoadMoreHandle)actionBlock;
/**
 * 停止刷新
 */
-(void)collectionViewStopRefresh:(UICollectionView*)collectionView;
/**
 * 上拉加载
 */
-(void)collectionViewLodingMore:(UICollectionView*)collectionView sctionBlock:(RefreshLoadMoreHandle)actionBlock;
/**
 * 上拉停止加载
 */
-(void)collectionViewStopLoadingMore:(UICollectionView*)collectionView dataCount:(NSMutableArray*)dataCount;

- (void)pop;

- (void)popToRootVc;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)())completion;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

@end
