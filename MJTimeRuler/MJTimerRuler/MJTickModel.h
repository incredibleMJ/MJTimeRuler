//
//  MJTickModel.h
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MJTickScaleLevel) {
    MJTickScaleLevel1,
    MJTickScaleLevel2,
    MJTickScaleLevel3,
    MJTickScaleLevel4,
    MJTickScaleLevel5,
    MJTickScaleLevel6,
    MJTickScaleLevel7
};

@interface MJTickModel : NSObject
@property (nonatomic, assign) MJTickScaleLevel level;
@property (nonatomic, copy) NSString *timeStr;
@end
