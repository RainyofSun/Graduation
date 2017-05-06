//
//  WBBaseImageView.m
//  BXYJWB
//
//  Created by MS on 17/1/11.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import "WBBaseImageView.h"
#import "YYWebImage.h"
#import "WBIntroduceFile.h"

@implementation WBBaseImageView

-(void)setImageWithUrl:(NSString *)url{
    [self setImageWithUrl:url placeHolder:nil];
}
-(void)setImageWithURL:(NSURL *)url{
    [self setImageWithURL:url placeHolder:nil];
}

-(void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)image{
    [self setImageWithUrl:url placeHolder:image finishHandle:nil];
}
-(void)setImageWithURL:(NSURL *)url placeHolder:(NSString *)image{
    [self setImageWithURL:url placeHolder:image finishHandle:nil];
}

-(void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)image finishHandle:(void (^)(BOOL, UIImage *))finishhandle{
    [self setImageWithUrl:url placeHolder:image progressHandle:nil finishHandle:finishhandle];
}
-(void)setImageWithURL:(NSURL *)url placeHolder:(NSString *)image finishHandle:(void (^)(BOOL, UIImage *))finishhandle{
    [self setImageWithURL:url placeHolder:image progressHandle:nil finishHandle:finishhandle];
}

-(void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)image progressHandle:(void (^)(CGFloat))progressHandle finishHandle:(void (^)(BOOL, UIImage *))finishhandle{
    [self setImageWithURL:[NSURL URLWithString:url] placeHolder:image progressHandle:progressHandle finishHandle:finishhandle];
}
-(void)setImageWithURL:(NSURL *)url placeHolder:(NSString *)image progressHandle:(void (^)(CGFloat))progressHandle finishHandle:(void (^)(BOOL, UIImage *))finishhandle{
    [self yy_setImageWithURL:url placeholder:CONTENTFILEIMAGE(image) options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressHandle) {
            progressHandle(receivedSize*1.0/expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (finishhandle) {
            finishhandle(error== nil,image);
        }
    }];
}

@end
