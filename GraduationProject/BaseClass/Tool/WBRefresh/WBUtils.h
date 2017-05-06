//
//  WBUtils.h
//  BXYJWB
//
//  Created by MS on 17/1/15.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^XRRefreshAndLoadMoreHandle)(void);
@interface WBUtils : NSObject

/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断头部是否在刷新 */
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断是否尾部在刷新 */
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView;

/** 提示没有更多数据的情况 */
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**   重置footer */
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;

/**  停止上拉加载 */
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;

/**  隐藏footer */
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;

/** 隐藏header */
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;

/** 下拉刷新 */
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock;

/** 上拉加载 */
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock;
/**
 *  转化时间 时间戳转时间
 */
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;

/**
 *  转化时间
 *  几天前，几分钟前
 */
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval;

/**
 *  公共富文本
 */
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace;

+ (NSString *)validString:(NSString *)string;

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

/** color生成image*/
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
