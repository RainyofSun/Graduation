//
//  WBBaseTableView.h
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,WBBaseTableViewRowAnimation) {
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,
    Middle = UITableViewRowAnimationMiddle,
    Automatic = 100
};
@class WBTableViewCell;
@interface WBBaseTableView : UITableView

-(void)wb_updateWithUpdateBlock:(void(WBBaseTableView* tableView))updateBlock;
-(UITableViewCell*)wb_cellatIndexPath:(NSIndexPath*)indexPath;
/**注册普通的UItableViewCell*/
-(void)wb_registerCellClass:(Class)cellClass identifier:(NSString*)identifier;
/**注册一个从xib中加载的UItableViewCell*/
-(void)wb_registerCellNib:(Class)cellNib identifier:(NSString*)identifier;
/**注册普通的UItableViewHeaderDFooterView*/
-(void)wb_registerHesderFooterClass:(Class)headerFooterClass identifier:(NSString*)identifier;
/**注册一个从xib中加载的UItableViewHeaderDFooterView*/
-(void)wb_registerHesderFooterNib:(Class)headerFooterNib identifier:(NSString *)identifier;

#pragma mark - 只对存在的cell进行刷新，没有类似于系统的，如果行不存在，默认insert操作
/**刷新单行,动画默认*/
-(void)wb_reloadSingleRowAtIndex:(NSIndexPath*)indexPath;
/**刷新单行,动画默认*/
-(void)wb_reloadSingleRowAtIndex:(NSIndexPath *)indexPath animation:(WBBaseTableViewRowAnimation)animation;
/**刷新单行,动画默认*/
-(void)wb_reloadRowsatIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
/**刷新单行,动画默认*/
-(void)wb_reloadRowsatIndexPaths:(NSArray<NSIndexPath*>*)indexPaths animation:(WBBaseTableViewRowAnimation)animation;
/**刷新某个section,动画默认*/
-(void)wb_reloadSingleSection:(NSInteger)section;
/**刷新某个section,动画自定义*/
-(void)wb_reloadSingleSection:(NSInteger)section animation:(WBBaseTableViewRowAnimation)animation;
/**刷新多个section,动画默认*/
-(void)wb_reloadSections:(NSArray<NSNumber*>*)sections;
/**刷新多个section,动画自定义*/
-(void)wb_reloadSections:(NSArray<NSNumber *> *)sections animation:(WBBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行删除的操作
/**删除单行,动画默认*/
-(void)wb_deleteSingleRowAtIndexPath:(NSIndexPath*)indexPath;
/**删除单行,动画自定义*/
-(void)wb_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WBBaseTableViewRowAnimation)animation;
/**删除多行,动画默认*/
-(void)wb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath*>*)indexPaths;
/**删除多行,动画自定义*/
-(void)wb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WBBaseTableViewRowAnimation)animation;
/**删除某个section,动画默认*/
-(void)wb_deleteSingleSection:(NSInteger)section;
/**删除某个section,动画自定义*/
-(void)wb_deleteSingleSection:(NSInteger)section animation:(WBBaseTableViewRowAnimation)animation;
/**删除多个section,动画默认*/
-(void)wb_deleteSections:(NSArray<NSNumber*>*)sections;
/**删除多个section,动画自定义*/
-(void)wb_deleteSections:(NSArray<NSNumber *> *)sections animation:(WBBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行操作
/**增加单行,动画无*/
-(void)wb_insertSingleRowAtIndexPath:(NSIndexPath*)indexPath;
/**增加单行,动画自定义*/
-(void)wb_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WBBaseTableViewRowAnimation)animation;
/**增加单section,动画无*/
-(void)wb_insertSingleSection:(NSInteger)section;
/**增加单section,动画自定义*/
-(void)wb_insertSingleSection:(NSInteger)section animation:(WBBaseTableViewRowAnimation)animation;
/**增加多行,动画无*/
-(void)wb_insertRowsatIndexPath:(NSArray<NSIndexPath*>*)indexPath;
/**增加多行,动画自定义*/
-(void)wb_insertRowsatIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(WBBaseTableViewRowAnimation)animation;
/**增加多section,动画无*/
-(void)wb_insertSections:(NSArray<NSNumber*>*)sections;
/**增加多section,动画自定义*/
-(void)wb_insertSections:(NSArray<NSNumber *> *)sections animation:(WBBaseTableViewRowAnimation)animation;
@end
