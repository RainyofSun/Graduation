//
//  WBTableViewCell.m
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBTableViewCell.h"

@implementation WBTableViewCell

-(UITableView *)tableView{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        return (UITableView*)self.superview.superview;
    }else{
        return (UITableView*)self.superview;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString* className = NSStringFromClass([self class]);
    NSString* identifier = [className stringByAppendingString:@"cellID"];
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

+(instancetype)nibCellWithTableView:(UITableView *)tableView{
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString* className = NSStringFromClass([self class]);
    NSString* identifier = [className stringByAppendingString:@"nibcellID"];
    UINib* nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
