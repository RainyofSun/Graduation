//
//  WBTableHeaderFooterView.m
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBTableHeaderFooterView.h"

@implementation WBTableHeaderFooterView

+(instancetype)headerFooterViewWithTableView:(UITableView *)tableView{
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString* className = NSStringFromClass([self class]);
    NSString* identifier = [className stringByAppendingString:@"headerfooterID"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifier];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

+(instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView{
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString* className = NSStringFromClass([self class]);
    NSString* identifier = [className stringByAppendingString:@"nibheaderfooterID"];
    UINib* nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

@end
