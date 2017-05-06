//
//  WBTableHeaderFooterView.h
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTableHeaderFooterView : UITableViewHeaderFooterView

/**
 * 快速创建一个tableView header  footer
 */
+(instancetype)headerFooterViewWithTableView:(UITableView*)tableView;
/**
 * 快速创建一个从xib加载的tableView header footer view
 */
+(instancetype)nibHeaderFooterViewWithTableView:(UITableView*)tableView;
@end
