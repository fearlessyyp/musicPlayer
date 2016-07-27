//
//  RowLyricInfo.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/15.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "RowLyricInfo.h"

@implementation RowLyricInfo

// 自定义初始化方法
- (instancetype)initWithRowLyricString:(NSString *)rowLyric
                               andTime:(CGFloat)time {
    if (self = [super init]) {
        _rowLyrictring = rowLyric;
        _time = time;
    }
    return self;
}

// 遍历构造器
+ (instancetype)rowLyricWithRowLyricString:(NSString *)rowLyric
                                   andTime:(CGFloat)time {
    return [[RowLyricInfo alloc] initWithRowLyricString:rowLyric andTime:time];
}


@end
