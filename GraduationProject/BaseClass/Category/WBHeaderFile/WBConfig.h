//
//  WBConfig.h
//  BXYJWB
//
//  Created by MS on 17/1/10.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#ifndef WBConfig_h
#define WBConfig_h

#pragma mark - 判断系统版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS7_OR_LATER [[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define VIEWWIDTH self.bounds.size.width
#define VIEWHEIGHT self.bounds.size.height

#pragma mark - 方法
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self
#define PRINTEF(log)        NSLog(@"%@",log)
#define JOINSTRING(string)  [NSString stringWithFormat:@"%@",string]
#pragma mark - 获取图片路径
#define IMAGEPATH(name) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]
#define CONTENTFILEIMAGE(name) [UIImage imageWithContentsOfFile:IMAGEPATH(name)]
#pragma mark - 设置字体
#define SETFONTSIZE(font)  [UIFont systemFontOfSize:font]
#pragma mark - 颜色
#define WHITE       [UIColor whiteColor]
#define BLACK       [UIColor blackColor]
#define LIGHTGRAY   [UIColor lightGrayColor]
#define RED         [UIColor redColor]
#define BLUE   [UIColor colorWithRed:71.0/255 green:108.0/255 blue:175.0/255 alpha:1.0]
#define ORANGE [UIColor colorWithRed:255.0/255 green:165.0/255 blue:97.0/255 alpha:1.0]
#define YELLOW [UIColor colorWithRed:239.0/255 green:187.0/255 blue:38.0/255 alpha:1.0]
#define CYANINE [UIColor colorWithRed:133.0/255 green:191.0/255 blue:188.0/255 alpha:1.0]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255 green:(g)/255 blue:(b)/255 alpha:1.0]
#define ARCDOMCOLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]

#pragma mark - 存储
#define WBUSERDEFAULT [NSUserDefaults standardUserDefaults]

#define GDMap_Key       @"b985900dd29020ea998ae131037661a6"
#endif /* WBConfig_h */
