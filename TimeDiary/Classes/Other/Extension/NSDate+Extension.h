//
//  NSDate+Extension.h
//  wch
//
//  Created by XQ on 15/9/10.
//  Copyright (c) 2015年 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)format;
+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)format;
/// 获取时间戳
+ (NSString *)getTimeStamp;
@end
