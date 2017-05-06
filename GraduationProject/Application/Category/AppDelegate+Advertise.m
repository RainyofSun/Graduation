//
//  AppDelegate+Advertise.m
//  GraduationProject
//
//  Created by MS on 17/4/10.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "AppDelegate+Advertise.h"
#import "WBConfig.h"
#import "AdvertiseView.h"

@implementation AppDelegate (Advertise)

/**
 * 判断文件是否存在
 */
-(BOOL)isFileExistWithFilePath:(NSString*)filePath{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 * 根据图片名字拼接文件路径
 */
-(NSString*)getFilePathWithImgName:(NSString*)imgName{
    if (imgName) {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString* filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imgName];
        return filePath;
    }
    return nil;
}

/**
 * 下载新的图片
 */
-(void)downLoadAdImageWithUrl:(NSString*)imgUrl imgName:(NSString*)imgName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        UIImage* image = [UIImage imageWithData:data];
        NSString* filepath = [self getFilePathWithImgName:imgName];//保存文件的名字
        if ([UIImagePNGRepresentation(image) writeToFile:filepath atomically:YES]) {
            //保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [WBUSERDEFAULT setValue:imgName forKey:adImageName];
            [WBUSERDEFAULT synchronize];
        }else{
            NSLog(@"保存失败");
        }
    });
}

/**
 * 删除旧图片
 */
-(void)deleteOldImage{
    NSString* imgName = [WBUSERDEFAULT valueForKey:adImageName];
    if (imgName) {
        NSString* filePath = [self getFilePathWithImgName:imgName];
        NSFileManager* manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:filePath error:nil];
    }
}
/**
 * 初始化广告页面
 */
-(void)getAdvertisingView{
    //请求广告接口--->暂时使用固定的图片url
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    //获取图片名字
    NSArray* stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString* imgName = stringArr.lastObject;
    
    //拼接审核路径
    NSString* filePath = [self getFilePathWithImgName:imgName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist) {
        //如果该图片不存在,则删除老图片,重新下载新图片
        [self downLoadAdImageWithUrl:imageUrl imgName:imgName];
    }
}

@end
