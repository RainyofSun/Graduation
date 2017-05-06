//
//  WBBaseTableView.m
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBBaseTableView.h"
#import "WBConfig.h"

@implementation WBBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

/**注册普通的UItableViewCell*/
-(void)wb_registerCellClass:(Class)cellClass identifier:(NSString *)identifier{
    if (cellClass && identifier.length) {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}

/**注册一个从xib中加载的uitableViewCell*/
-(void)wb_registerCellNib:(Class)cellNib identifier:(NSString *)identifier{
    if (cellNib && identifier.length) {
        UINib* nib = [UINib nibWithNibName:[cellNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:identifier];
    }
}

/**注册一个普通的UITableViewHeaderFooterView*/
-(void)wb_registerHesderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier{
    if (headerFooterClass && identifier.length) {
        [self registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}

/**注册一个从xib中加载的UITableViewHeaderFooterView*/
-(void)wb_registerHesderFooterNib:(Class)headerFooterNib identifier:(NSString *)identifier{
    if (headerFooterNib && identifier.length) {
        UINib* nib = [UINib nibWithNibName:[headerFooterNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:identifier];
    }
}

-(void)wb_updateWithUpdateBlock:(void (WBBaseTableView *))updateBlock{
    if (updateBlock) {
        [self beginUpdates];
        updateBlock(self);
        [self endUpdates];
    }
}

-(UITableViewCell *)wb_cellatIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath) {
        return nil;
    }
    NSInteger sectionNumer = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger roeNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumer || indexPath.section < 0) {
        NSLog(@"刷新section:%ld 已经越界,总组数:%ld",(long)indexPath.section,(long)sectionNumer);
        return nil;
    }
    if (indexPath.row + 1 > roeNumber || indexPath.row < 0) {
        NSLog(@"刷新row:%ld已经越界,总行数:%ld所在section:%ld",(long)indexPath.row,(long)roeNumber,(long)section);
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];
}

/**刷新单行,动画默认*/
-(void)wb_reloadSingleRowAtIndex:(NSIndexPath *)indexPath{
    [self wb_reloadSingleRowAtIndex:indexPath animation:None];
}
-(void)wb_reloadSingleRowAtIndex:(NSIndexPath *)indexPath animation:(WBBaseTableViewRowAnimation)animation{
    if (!indexPath) {
        return;
    }
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) {
        //section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", (long)indexPath.section, (long)sectionNumber);
        return;
    }
    if (indexPath.row +1 > rowNumber || indexPath.row < 0) {
        // row越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", (long)indexPath.row, (long)rowNumber, (long)section);
        return;
    }
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

/** 刷新多行、动画默认*/
-(void)wb_reloadRowsatIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self wb_reloadRowsatIndexPaths:indexPaths animation:None];
}

-(void)wb_reloadRowsatIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WBBaseTableViewRowAnimation)animation{
    if (!indexPaths.count) {
        return;
    }
    WS(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf wb_reloadSingleRowAtIndex:obj animation:animation];
        }
    }];
}

/** 刷新某个section、动画默认*/
-(void)wb_reloadSingleSection:(NSInteger)section{
    [self wb_reloadSingleSection:section animation:None];
}

-(void)wb_reloadSingleSection:(NSInteger)section animation:(WBBaseTableViewRowAnimation)animation{
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        //section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", (long)section, (long)sectionNumber);
        return;
    }
    [self beginUpdates];
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
}

/**刷新多个section,动画默认*/
-(void)wb_reloadSections:(NSArray<NSNumber *> *)sections{
    [self wb_reloadSections:sections animation:None];
}

-(void)wb_reloadSections:(NSArray<NSNumber *> *)sections animation:(WBBaseTableViewRowAnimation)animation{
    if (!sections.count) {
        return;
    }
    WS(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf wb_reloadSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/**删除单行,动画默认*/
-(void)wb_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath{
    [self wb_deleteSingleRowAtIndexPath:indexPath animation:None];
}

-(void)wb_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WBBaseTableViewRowAnimation)animation{
    if (!indexPath) {
        return;
    }
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    NSLog(@"sectionNumber %ld  section%ld rowNumber%ld",(long)sectionNumber, (long)section , (long)rowNumber);
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) {
        //section越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", (long)indexPath.section, (long)sectionNumber);
        return;
    }
    if (indexPath.row + 1 > rowNumber || indexPath.row < 0 ) {
        //row越界
        NSLog(@"删除row: %ld 已经越界, 总行数: %ld 所在section: %ld", (long)indexPath.row, (long)rowNumber, (long)section);
        return;
    }
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

/**删除多行,动画默认*/
-(void)wb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self wb_deleteRowsAtIndexPaths:indexPaths animation:None];
}

-(void)wb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WBBaseTableViewRowAnimation)animation{
    if (!indexPaths.count) {
        return;
    }
    WS(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf wb_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/**删除某个section,动画默认*/
-(void)wb_deleteSingleSection:(NSInteger)section{
    [self wb_deleteSingleSection:section animation:None];
}

-(void)wb_deleteSingleSection:(NSInteger)section animation:(WBBaseTableViewRowAnimation)animation{
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", (long)section, (long)sectionNumber);
        return;
    }
    [self beginUpdates];
    [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

/**删除多个section,动画默认*/
-(void)wb_deleteSections:(NSArray<NSNumber *> *)sections{
    [self wb_deleteSections:sections animation:None];
}

-(void)wb_deleteSections:(NSArray<NSNumber *> *)sections animation:(WBBaseTableViewRowAnimation)animation{
    if (!sections.count) {
        return;
    }
    WS(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf wb_deleteSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/**增加单行,动画无*/
-(void)wb_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath{
    [self wb_insertSingleRowAtIndexPath:indexPath animation:None];
}

-(void)wb_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WBBaseTableViewRowAnimation)animation{
    if (!indexPath) {
        return;
    }
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section > sectionNumber || section < 0) {
        //section越界
        NSLog(@"section 越界 : %ld", (long)section);
        return;
    }
    if (row > rowNumber || row < 0) {
        NSLog(@"row 越界 : %ld", (long)row);
        return;
    }
    [self beginUpdates];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

/**增加单个section,动画无*/
-(void)wb_insertSingleSection:(NSInteger)section{
    [self wb_insertSingleSection:section animation:None];
}

-(void)wb_insertSingleSection:(NSInteger)section animation:(WBBaseTableViewRowAnimation)animation{
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || sectionNumber < 0) {
        //section越界
        NSLog(@" section 越界 : %ld", (long)section);
        return;
    }
    [self beginUpdates];
    [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

/**增加多行,动画无*/
-(void)wb_insertRowsatIndexPath:(NSArray<NSIndexPath *> *)indexPath{
    [self wb_insertRowsatIndexPath:indexPath animation:None];
}

-(void)wb_insertRowsatIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(WBBaseTableViewRowAnimation)animation{
    if (indexPaths.count == 0) {
        return;
    }
    WS(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf wb_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/**增加多section,动画无*/
-(void)wb_insertSections:(NSArray<NSNumber *> *)sections{
    [self wb_insertSections:sections animation:None];
}

-(void)wb_insertSections:(NSArray<NSNumber *> *)sections animation:(WBBaseTableViewRowAnimation)animation{
    if (sections.count == 0) {
        return;
    }
    WS(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf wb_insertSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/**当有输入框的时候点击tableView的空白处隐藏键盘*/
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}
@end
