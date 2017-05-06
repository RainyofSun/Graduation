//
//  GroupBuyingHeadView.m
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "GroupBuyingHeadView.h"
#import "WBConfig.h"

static NSInteger imageWidth;
static NSInteger Marggin = 40;
@interface GroupBuyingHeadView ()

//分类
@property(nonatomic,strong)UIButton* category;
@property(nonatomic,strong)UILabel* noteLabel;

@end

@implementation GroupBuyingHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpCategory];
    }
    return self;
}

-(void)setUpCategory{
    NSArray* imgArr = @[@"hotel",@"scenic",@"movie"];
    imageWidth = (SCREENWIDTH - Marggin*4)/4;
    NSArray* title = @[@"酒店",@"景点",@"电影"];
    for (int i = 0; i < 3; i ++ ) {
        self.category = [[UIButton alloc] initWithFrame:CGRectMake(Marggin*2 + (imageWidth + Marggin)*i, 15, imageWidth, imageWidth)];
        self.category.tag = i + 1;
        [self.category setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [self.category addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.category];
        
        self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(Marggin*2 + (imageWidth + Marggin)*i, 15 + imageWidth + 5, imageWidth, 20)];
        self.noteLabel.text = title[i];
        self.noteLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.noteLabel];
    }
}

#pragma mark - 点击方法
-(void)chooseCategory:(UIButton*)sender{
    if (sender.tag == 1) {
        if ([self.deleagte respondsToSelector:@selector(chooseSearchCategory:)]) {
            [self.deleagte chooseSearchCategory:sender.tag];
        }
    }
    
    if (sender.tag == 2) {
        if ([self.deleagte respondsToSelector:@selector(chooseSearchCategory:)]) {
            [self.deleagte chooseSearchCategory:sender.tag];
        }
    }
    
    if (sender.tag == 3) {
        if ([self.deleagte respondsToSelector:@selector(chooseSearchCategory:)]) {
            [self.deleagte chooseSearchCategory:sender.tag];
        }
    }
}

@end
