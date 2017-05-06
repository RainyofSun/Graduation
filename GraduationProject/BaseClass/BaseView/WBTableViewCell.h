//
//  WBTableViewCell.h
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTableViewCell : UITableViewCell

@property(nonatomic,weak)UITableView* tableView;

/**
 * 快速创建一个cell
 */
+(instancetype)cellWithTableView:(UITableView*)tableView;
/**
 * 快速创建一个从xib加载的cell
 */
+(instancetype)nibCellWithTableView:(UITableView*)tableView;

@end
