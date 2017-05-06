//
//  ShowGDMap.h
//  GraduationProject
//
//  Created by MS on 17/3/19.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "BaseVC.h"

@interface ShowGDMap : BaseVC

//需要定位的location
@property(nonatomic,strong)NSDictionary* location;
//店面名字
@property(nonatomic,copy)NSString* storeName;
//地址
@property(nonatomic,copy)NSString* storeAddress;
//城市名字
@property(nonatomic,copy)NSString* city;

@end
