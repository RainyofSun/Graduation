//
//  GroupBuyingHeadView.h
//  GraduationProject
//
//  Created by MS on 17/3/25.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "WBTableHeaderFooterView.h"

@protocol GroupBuyingHeadViewDeleagte <NSObject>

-(void)chooseSearchCategory:(NSUInteger)tag;

@end

@interface GroupBuyingHeadView : WBTableHeaderFooterView

@property(nonatomic,weak)id<GroupBuyingHeadViewDeleagte>deleagte;

@end
