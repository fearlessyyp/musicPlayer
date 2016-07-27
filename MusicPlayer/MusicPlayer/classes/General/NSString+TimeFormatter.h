//
//  NSString+TimeFormatter.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/14.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (TimeFormatter)
// 秒转换成分秒
// eg： 200 -> 03:20
+ (NSString *)getStringWithTime:(CGFloat)second;


// 分秒转换成秒
// eg: 03:20 -> 200
+ (CGFloat)getSecondsWithString:(NSString *)string;
- (CGFloat)getSecondsWithString;
@end
