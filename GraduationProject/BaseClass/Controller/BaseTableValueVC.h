//
//  BaseTableValueVC.h
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseVC.h"
#import "WBTableViewCell.h"
#import "WBBaseTableView.h"

typedef void (^WBTableVcCellSelectedhandle)(WBTableViewCell* cell, NSIndexPath* indexPath);
typedef NS_ENUM(NSUInteger,WBBaseTableVcRefreshType) {
    /**无法刷新*/
    WBBaseTableVcRefreshTypeNone = 0,
    /**只能刷新*/
    WBBaseTableVcRefreshTypeOnlyCanRefresh,
    /**只能上拉加载*/
    WBBaseTableVcRefreshTypeOnlyCanLoadMore,
    /**能刷新*/
    WBBaseTableVcRefreshTypeRefreshAndLoadMore
};
@interface BaseTableValueVC : BaseVC<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* dataArray;
}
/**刚才执行的是刷新*/
@property(nonatomic,assign)NSUInteger isRefresh;
/**刚才执行的是上拉加载*/
@property(nonatomic,assign)NSUInteger isLoadMore;
/**添加空界面文字*/
-(void)wb_addEmptyPageWithText:(NSString*)text;


/**表视图*/
@property(nonatomic,strong)WBBaseTableView* tableView;
/**表视图偏移*/
@property(nonatomic,assign)UIEdgeInsets tableEdgeInset;
/**分割线颜色*/
@property(nonatomic,assign)UIColor* sepLineColor;
/**数据源数量*/
@property(nonatomic,strong)NSMutableArray* dataArray;
/**加载刷新类型*/
@property(nonatomic,assign)WBBaseTableVcRefreshType refreshType;
/**是否需要系统的分割线*/
@property(nonatomic,assign)BOOL needCellSepLine;

/**刷新数据*/
-(void)wb_reloadData;
/**开始下拉*/
-(void)wb_beginRefresh;
/**停止刷新*/
-(void)wb_endRefresh;
/**停止上拉加载*/
-(void)wb_endLoadMore;
/**隐藏刷新*/
-(void)wb_hiddenRefresh;
/**隐藏上拉加载*/
-(void)wb_hiddenLoadMore;
/**提示没有更多信息*/
-(void)wb_noticeNoMoreData;
/**配置数据*/
-(void)wb_commenConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass;
/**配置数据*/
-(void)wb_commenConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString*)emptyText;
/**是否在下拉刷新*/
@property(nonatomic,assign,readonly) BOOL isHeaderRefreshing;
/**是否在上拉加载*/
@property(nonatomic,assign,readonly) BOOL isFooterRefreshing;

#pragma mark - 子类重写
/**分组数量*/
-(NSInteger)wb_numberOfSections;
/**某个分组的cell的数量*/
-(NSInteger)wb_numberOfRowsInSection:(NSInteger)section;
/**某行的cell*/
-(WBTableViewCell*)wb_cellAtIndexPath:(NSIndexPath*)indexPath;
/**点击某行*/
-(void)wb_didSelectCellAtIndexPath:(NSIndexPath*)indexPath cell:(WBTableViewCell*)cell;
/**某行行高*/
-(CGFloat)wb_cellHeightAtIndexPath:(NSIndexPath*)indexPath;
/**某个组头*/
-(UIView*)wb_headerAtSection:(NSInteger)section;
/**某个组尾*/
-(UIView*)wb_fooetrAtSection:(NSInteger)section;
/**某个组头的高度*/
-(CGFloat)wb_sectionHeaderHeightAtSection:(NSInteger)section;
/**某个组尾的高度*/
-(CGFloat)wb_sectionFooterHeightAtSection:(NSInteger)section;
/**分割线偏移*/
-(UIEdgeInsets)wb_sepEdgeInsetAtIndexPath:(NSIndexPath*)indexPath;

#pragma mark - 子类继承
/**刷新方法*/
-(void)wb_refresh;
/**上拉加载方法*/
-(void)wb_loadMore;
@property(nonatomic,assign) BOOL showRefreshIcon;
-(void)endRefreshIconAnimation;
@property(nonatomic,weak,readonly)UIView* refreshHeader;

#pragma mark - loading & altert
-(void)wb_showLoading;

-(void)wb_hiddenLoading;

-(void)wb_showTitle:(NSString*)title after:(NSTimeInterval)after;

@end
