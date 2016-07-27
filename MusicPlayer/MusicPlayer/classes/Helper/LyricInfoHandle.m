//
//  LyricInfoHandle.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/15.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "LyricInfoHandle.h"
#import <UIKit/UIKit.h>

@interface LyricInfoHandle ()
/// 存放歌词model的数组
@property (nonatomic, strong) NSMutableArray *allRowLyricInfo;
@end

@implementation LyricInfoHandle
// 单例
singleton_implementation(LyricInfoHandle)

// 懒加载
- (NSMutableArray *)allRowLyricInfo {
    if (!_allRowLyricInfo) {
        _allRowLyricInfo = [NSMutableArray array];
    }
    return _allRowLyricInfo;
}


// 解析歌词
- (NSArray *)lyricWithLyricString:(NSString *)lyricString {
    // 每次要清掉数组
    [self.allRowLyricInfo removeAllObjects];
    
    NSArray *allRowLyric = [lyricString componentsSeparatedByString:@"\n"];
    for (NSString *rowLyric in allRowLyric) {
        if (rowLyric.length > 0) {
            NSArray *timeAndLyricString = [rowLyric componentsSeparatedByString:@"]"];
            //时间  分 秒 毫秒
            NSArray *timeStringArr = [[timeAndLyricString[0] substringFromIndex:1] componentsSeparatedByString:@":"];
            CGFloat time = [timeStringArr[0] integerValue] * 60 + [[timeStringArr lastObject] floatValue];
            NSString *rowLyric = [timeAndLyricString lastObject];
            RowLyricInfo *info = [RowLyricInfo rowLyricWithRowLyricString:rowLyric andTime:time];
            [self.allRowLyricInfo addObject:info];
        }
    }
    return self.allRowLyricInfo;
}

// 分区数
- (NSInteger)numberOfSections {
    return 1;
}

// 分区行数
- (NSInteger)numberofRowsInSection:(NSInteger)section {
    return self.allRowLyricInfo.count;
}

// 单行内容
- (RowLyricInfo *)rowLyricForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.allRowLyricInfo[indexPath.row];
}

// 根据时间获取歌词
// 获取当前时间对应的歌词的index
- (NSInteger)indexForRowByTime:(CGFloat)time {
    for (int i = 0; i < self.allRowLyricInfo.count; i++) {
        if ([self.allRowLyricInfo[i] time] > time) {
            // 返回上一句正在唱的歌词
            return (i - 1 > 0) ? i - 1 : 0;
        }
    }
    return self.allRowLyricInfo.count - 1;
}
@end
