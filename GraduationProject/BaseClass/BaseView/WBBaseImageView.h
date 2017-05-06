//
//  WBBaseImageView.h
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <YYImage/YYImage.h>

@interface WBBaseImageView : YYAnimatedImageView
/**设置图片*/
-(void)setImageWithUrl:(NSString*)url;
-(void)setImageWithURL:(NSURL*)url;

/**设置图片*/
-(void)setImageWithUrl:(NSString*)url placeHolder:(NSString*)image;
-(void)setImageWithURL:(NSURL *)url placeHolder:(NSString*)image;

/**设置图片*/
-(void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)image finishHandle:(void(^)(BOOL finished,UIImage* image))finishhandle;
-(void)setImageWithURL:(NSURL *)url placeHolder:(NSString *)image finishHandle:(void(^)(BOOL finished ,UIImage* image))finishhandle;

/**设置图片*/
-(void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void (^)(BOOL, UIImage *))finishhandle;
-(void)setImageWithURL:(NSURL *)url placeHolder:(NSString *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void (^)(BOOL, UIImage *))finishhandle;

@end
