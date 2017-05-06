//
//  BaseTableValueVC.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseTableValueVC.h"
#import "WBTableHeaderFooterView.h"
#import <MJRefresh/MJRefresh.h>
#import "UIView+Tap.h"
#import "UIView+Layer.h"
#import "WBUtils.h"
#import <MJExtension/MJExtension.h>
#import "WBConfig.h"
#import <Masonry/Masonry.h>
#import "ACMacros.h"

@interface BaseTableValueVC ()

@property(nonatomic,copy) WBTableVcCellSelectedhandle handle;
@property(nonatomic,weak) UIImageView* refreshImg;

@end

@implementation BaseTableValueVC
@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize dataArray = dataArray;

-(NSMutableArray *)dataArray{
    if (!dataArray) {
        dataArray = [NSMutableArray new];
    }
    return dataArray;
}

-(WBBaseTableView *)tableView{
    if (!_tableView) {
        WBBaseTableView* tab = [[WBBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = RGBCOLOR(0.94f, 0.94f, 0.94f);
        tab.separatorColor = RGBCOLOR(234.0, 237.0, 240.0);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark - loading & alert
-(void)wb_showLoading{
    
}

-(void)wb_hiddenLoading{
    
}

-(void)wb_showTitle:(NSString *)title after:(NSTimeInterval)after{
    
}

-(void)wb_addEmptyPageWithText:(NSString *)text{
    
}

/**设置刷新类型*/
-(void)setRefreshType:(WBBaseTableVcRefreshType)refreshType{
    _refreshType = refreshType;
    switch (refreshType) {
        case WBBaseTableVcRefreshTypeNone:
            //没有刷新
            break;
        case WBBaseTableVcRefreshTypeOnlyCanRefresh:
            //只有下拉刷新
            [self wb_addRefresh];
            break;
        case WBBaseTableVcRefreshTypeOnlyCanLoadMore:
            //只有上拉加载
            [self wb_addLoadMore];
            break;
        case WBBaseTableVcRefreshTypeRefreshAndLoadMore:
            //上拉和下拉都有
            [self wb_addRefresh];
            [self wb_addLoadMore];
        default:
            break;
    }
}

-(void)wb_addRefresh{
    [WBUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self wb_refresh];
    }];
}

-(void)wb_addLoadMore{
    [WBUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self wb_loadMore];
    }];
}

-(void)setShowRefreshIcon:(BOOL)showRefreshIcon{
    _showRefreshIcon = showRefreshIcon;
    self.refreshImg.hidden = !showRefreshIcon;
}

-(UIImageView *)refreshImg{
    if (!_refreshImg) {
        UIImageView* refreshImage = [[UIImageView alloc] init];
        [self.view addSubview:refreshImage];
        refreshImage.image = CONTENTFILEIMAGE(@"refresh");
        WS(weakSelf);
        [refreshImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_offset(-20);
        }];
        refreshImage.layerCornerRadius = 22;
        refreshImage.backgroundColor = WHITE;
        [refreshImage setTapActionWithBlock:^{
            [self startAnimation];
            [weakSelf wb_beginRefresh];
        }];
    }
    return _refreshImg;
}

-(void)startAnimation{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.refreshImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)endRefreshIconAnimation{
    [self.refreshImg.layer removeAnimationForKey:@"rotationAnimation"];
}

/**需要系统分割线*/
-(void)setNeedCellSepLine:(BOOL)needCellSepLine{
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

-(BOOL)needCellSepLine{
    return self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

/**表视图偏移*/
-(void)setTableEdgeInset:(UIEdgeInsets)tableEdgeInset{
    _tableEdgeInset = tableEdgeInset;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    WS(weakSelf);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).mas_offset(weakSelf.tableEdgeInset);
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}

/**分割线颜色*/
-(void)setSepLineColor:(UIColor *)sepLineColor{
    if (!self.needCellSepLine) {
        return;
    }
    _sepLineColor = sepLineColor;
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

-(UIColor *)sepLineColor{
    return _sepLineColor ? _sepLineColor : WHITE;
}

/**刷新数据*/
-(void)wb_reloadData{
    [self.tableView reloadData];
}

/**开始下拉*/
-(void)wb_beginRefresh{
    if (self.refreshType == WBBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == WBBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [WBUtils beginPullRefreshForScrollView:self.tableView];
    }
}

/**刷新*/
-(void)wb_refresh{
    if (self.refreshType == WBBaseTableVcRefreshTypeNone || self.refreshType == WBBaseTableVcRefreshTypeOnlyCanLoadMore) {
        return;
    }
    self.isRefresh = YES; self.isLoadMore = NO;
}

/**上拉加载*/
-(void)wb_loadMore{
    if (self.refreshType == WBBaseTableVcRefreshTypeNone || self.refreshType == WBBaseTableVcRefreshTypeOnlyCanRefresh) {
        return;
    }
    if (self.dataArray.count == 0) {
        return;
    }
    self.isRefresh = NO; self.isLoadMore = YES;
}

-(void)wb_commenConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass{
    [self wb_commenConfigResponseWithResponse:response isRefresh:isRefresh modelClass:modelClass emptyText:nil];
}

-(void)wb_commenConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText{
    if ([response isKindOfClass:[NSArray class]] == NO) {
        return;
    }
    if (self.isRefresh) {
        //停止刷新
        [self wb_endRefresh];
        //设置模型数组
        [self.dataArray removeAllObjects];
        self.dataArray = [modelClass mj_objectArrayWithKeyValuesArray:response];
        //设置空界面占位文字
        if (emptyText.length) {
            [self wb_addEmptyPageWithText:emptyText];
        }
        //刷新界面
        [self wb_reloadData];
    }else{
        //上拉加载
        //停止上拉
        [self wb_endLoadMore];
        //没有数据提示没有更多了
        if ([response count] == 0) {
            [self wb_noticeNoMoreData];
        }else{
            //设置模型数组
            NSArray* newModels = [modelClass mj_objectArrayWithKeyValuesArray:response];
            if (newModels.count < 50) {
                [self wb_hiddenLoadMore];
            }
            [self.dataArray addObjectsFromArray:newModels];
            //刷新界面
            [self wb_reloadData];
        }
    }
}

/**停止刷新*/
-(void)wb_endRefresh{
    if (self.refreshType == WBBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == WBBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [WBUtils endRefreshForScrollView:self.tableView];
    }
}

/**停止上拉加载*/
-(void)wb_endLoadMore{
    if (self.refreshType == WBBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == WBBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [WBUtils endLoadMoreForScrollView:self.tableView];
    }
}

/**隐藏刷新*/
-(void)wb_hiddenRefresh{
    if (self.refreshType == WBBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == WBBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [WBUtils hiddenHeaderForScrollView:self.tableView];
    }
}

/**隐藏上拉加载*/
-(void)wb_hiddenLoadMore{
    if (self.refreshType == WBBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == WBBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [WBUtils hiddenFooterForScrollView:self.tableView];
    }
}

/**提示没有更多信息*/
-(void)wb_noticeNoMoreData{
    if (self.refreshType == WBBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == WBBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [WBUtils noticeNoMoreDataForScrollView:self.tableView];
    }
}

/**头部正在刷新*/
-(BOOL)isHeaderRefreshing{
    return [WBUtils headerIsRefreshForScrollView:self.tableView];
}

/**尾部正在刷新*/
-(BOOL)isFooterRefreshing{
    return [WBUtils footerIsLoadingForScrollView:self.tableView];
}

#pragma mark -  <UITableViewDataSource, UITableViewDelegate>
//分组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self respondsToSelector:@selector(wb_numberOfSections)]) {
        return self.wb_numberOfSections;
    }
    return 0;
}

//指定组返回的cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(wb_numberOfRowsInSection:)]) {
        return [self wb_numberOfRowsInSection:section];
    }
    return 0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(wb_headerAtSection:)]) {
        return [self wb_headerAtSection:section];
    }
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(wb_fooetrAtSection:)]) {
        return [self wb_fooetrAtSection:section];
    }
    return nil;
}

//每一行返回指定的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(wb_cellAtIndexPath:)]) {
        return [self wb_cellAtIndexPath:indexPath];
    }
    //创建cell
    WBTableViewCell* cell = [WBTableViewCell cellWithTableView:self.tableView];
    //返回cell
    return cell;
}

//点击某一行 触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WBTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(wb_didSelectCellAtIndexPath:cell:)]) {
        [self wb_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

-(UIView *)refreshHeader{
    return self.tableView.mj_header;
}

//设置分割线偏移间距并适配
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.needCellSepLine) {
        return;
    }
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(wb_sepEdgeInsetAtIndexPath:)]) {
        edgeInsets = [self wb_sepEdgeInsetAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
}

//每一行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(wb_cellHeightAtIndexPath:)]) {
        return [self wb_cellHeightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(wb_sectionHeaderHeightAtSection:)]) {
        return [self wb_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(wb_sectionFooterHeightAtSection:)]) {
        return [self wb_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}

-(NSInteger)wb_numberOfSections{ return 0;}

-(NSInteger)wb_numberOfRowsInSection:(NSInteger)section { return 0;}

-(UITableViewCell *)wb_cellAtIndexPath:(NSIndexPath *)indexPath{
    return [WBTableViewCell cellWithTableView:self.tableView];
}

-(CGFloat)wb_cellHeightAtIndexPath:(NSIndexPath *)indexPath{return 0;}

-(void)wb_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WBTableViewCell *)cell{
    
}

-(UIView *)wb_headerAtSection:(NSInteger)section{
    return [WBTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
}

-(UIView *)wb_fooetrAtSection:(NSInteger)section{
    return [WBTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
}

-(CGFloat)wb_sectionHeaderHeightAtSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)wb_sectionFooterHeightAtSection:(NSInteger)section{
    return 0.01;
}

-(UIEdgeInsets)wb_sepEdgeInsetAtIndexPath:(NSIndexPath *)indexPath{
    return UIEdgeInsetsMake(0, 15, 0, 0);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
