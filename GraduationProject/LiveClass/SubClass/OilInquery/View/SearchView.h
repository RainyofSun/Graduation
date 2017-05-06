//
//  SearchView.h
//  GraduationProject
//
//  Created by MS on 17/3/14.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewDelegate <NSObject>

/**跳转到查询详情界面*/
-(void)jumpTheSearchResultView:(NSDictionary*)dict;

@end

@interface SearchView : UIView

@property(nonatomic,weak)id<SearchViewDelegate>delegate;

@end
