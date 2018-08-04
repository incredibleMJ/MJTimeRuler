//
//  NSString+Extension.h
//  MJTimeRuler
//
//  Created by MJ2009 on 2018/8/4.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
+ (NSString *)dateStrSinceZeroDateWithInterval:(NSTimeInterval)interval hasSecond:(BOOL)isHasSec;
@end
