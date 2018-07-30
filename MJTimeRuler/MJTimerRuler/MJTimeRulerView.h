//
//  MJTimeRulerView.h
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTimeRulerView : UIView
@property (nonatomic, assign) UIEdgeInsets edgeInset;
@property (nonatomic, assign, readonly) CGSize cellSize;

/**
 单位刻度秒数
 */
@property (nonatomic, assign, readonly) double averageSec;

/**
 单位刻度的像素宽度
 */
@property (nonatomic, assign, readonly) CGFloat distance;

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

@end
