//
//  IDCardView.h
//  GraduationProject
//
//  Created by MS on 17/3/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IDCardViewDelegate <NSObject>

//点击return键开始搜索
-(void)searchTheIDNum:(NSString*)idNum;

@end

@interface IDCardView : UIView

@property(nonatomic,weak)id<IDCardViewDelegate> delegate;
/**姓名*/
@property(nonatomic,strong)UILabel* sex;
/**生日*/
@property(nonatomic,strong)UILabel* birthDay;
/**发证地*/
@property(nonatomic,strong)UILabel* address;
/**证件号*/
@property(nonatomic,strong)UILabel* num;

@end
