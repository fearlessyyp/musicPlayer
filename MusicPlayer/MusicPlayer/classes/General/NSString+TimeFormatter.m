//
//  NSString+TimeFormatter.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/14.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "NSString+TimeFormatter.h"

@implementation NSString (TimeFormatter)
// 秒转换成分秒
// eg： 200 -> 03:20
+ (NSString *)getStringWithTime:(CGFloat)second {
    return [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)second / 60, (NSInteger)second % 60];
}


// 分秒转换成秒
// eg: 03:20 -> 200
+ (CGFloat)getSecondsWithString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByString:@":"];
    return [[array firstObject] integerValue] * 60 + [[array lastObject] integerValue];
 
}

- (CGFloat)getSecondsWithString {
    NSArray *array = [self componentsSeparatedByString:@":"];
    return [[array firstObject] integerValue] * 60 + [[array lastObject] integerValue];
}

@end
