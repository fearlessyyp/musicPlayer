//
//  MusicInfosHandle.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <UIKit/UIKit.h>
#import "MusicInfo.h"

// 获取数据源接口的反馈结果
typedef void(^Completion)(NSArray *array, NSError *error);

@interface MusicInfosHandle : NSObject

// 声明单例
singleton_interface(MusicInfosHandle)

// 配置音乐列表相关数据源的操作接口
// url地址  反馈结果
- (void)getMusicInfoWithUrl:(NSString *)urlString
                 completion:(Completion)completion;

// 获取分组个数
- (NSInteger)numberOfSections;

// 获取指定分组行数
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

// 获取某个分区下某行的musicInfo
- (MusicInfo *)musicInfoForRowInIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 配置播放音乐数据源相关操作
// 上一首数据源
- (MusicInfo *)musicInfoPreviousWithIndex:(NSInteger *)index;

// 下一首数据源
- (MusicInfo *)musicInfoNextWithIndex:(NSInteger *)index;

// 随机数据源
- (MusicInfo *)musicInfoOfRandom:(NSInteger *)index;

@end
