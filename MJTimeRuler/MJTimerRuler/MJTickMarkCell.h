//
//  MJTickMarkCell.h
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTickModel.h"

@interface MJTickMarkCell : UICollectionViewCell
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) MJTickModel *model;

+ (CGFloat)lineHeightForLevel:(MJTickScaleLevel)level;

@end
