//
//  MJTimeRulerView.h
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTimeRulerView : UIView
/**
 当前秒数
 */
@property (nonatomic) double currentSec;

/**
 最大支持缩放级别
 */
@property (nonatomic, assign, readonly) float maxScale;

/**
 缩放比
 */
@property (nonatomic, assign) float scale;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *timeTextColor;
@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, copy) void(^didScroll)(double currentSec);

@end
