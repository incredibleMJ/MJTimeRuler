//
//  NSString+Extension.m
//  MJTimeRuler
//
//  Created by MJ2009 on 2018/8/4.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)dateStrSinceZeroDateWithInterval:(NSTimeInterval)interval hasSecond:(BOOL)isHasSec {
    NSDate *zeroDate = [self zeroDate];
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate dateWithTimeInterval:interval sinceDate:zeroDate];
    dateFomater.dateFormat = isHasSec ? @"HH:mm:ss" : @"HH:mm";
    return [dateFomater stringFromDate:date];
}

+ (NSDate *)zeroDate {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy年MM月dd日";
    NSString *zeroDateStr = [dateFomater stringFromDate:nowDate];
    return [dateFomater dateFromString:zeroDateStr];
}

@end
