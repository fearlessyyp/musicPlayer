//
//  LyricInfoHandle.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/15.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "RowLyricInfo.h"

@interface LyricInfoHandle : NSObject
// 声明单例
singleton_interface(LyricInfoHandle)

// 解析歌词
- (NSArray *)lyricWithLyricString:(NSString *)lyricString;

// 分区数
- (NSInteger)numberOfSections;

// 分区行数
- (NSInteger)numberofRowsInSection:(NSInteger)section;

// 单行内容
- (RowLyricInfo *)rowLyricForRowAtIndexPath:(NSIndexPath *)indexPath;

// 根据时间获取歌词
// 获取当前时间对应的歌词的index
- (NSInteger)indexForRowByTime:(CGFloat)time;


@end
