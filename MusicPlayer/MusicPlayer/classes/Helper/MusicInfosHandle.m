//
//  MusicInfosHandle.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "MusicInfosHandle.h"
#import "NetWorkRequestManager.h"

@interface MusicInfosHandle ()
// 存放所有歌曲信息的数组
@property (nonatomic, strong) NSMutableArray *musicInfosArray;

@end

@implementation MusicInfosHandle

// 实现单例
singleton_implementation(MusicInfosHandle)

// 懒加载
- (NSMutableArray *)musicInfosArray {
    if (!_musicInfosArray) {
        _musicInfosArray = [NSMutableArray array];
    }
    return _musicInfosArray;
}
// 配置音乐列表相关数据源的操作接口
// url地址  反馈结果
- (void)getMusicInfoWithUrl:(NSString *)urlString
                 completion:(Completion)completion {
    // 网络请求
    [NetWorkRequestManager requestType:RequestTypeGet urlString:urlString prama:nil success:^(id data) {
        NSError *error = nil;
        // 生成存储data的plist文件路径
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fileNamePath = [filePath stringByAppendingPathComponent:@"MusicInfos.plist"];
        BOOL result = [data writeToFile:fileNamePath options:NSDataWritingAtomic error:&error];
        if (result && !error) {
            NSArray *resultArray = [NSArray arrayWithContentsOfFile:fileNamePath];
            // 每一次处理数据源时要考虑是添加还是覆盖
            [self.musicInfosArray removeAllObjects];
            // 将数组中的数据生成musicInfo的对象
            for (NSDictionary *dic in resultArray) {
                MusicInfo *info = [[MusicInfo alloc] init];
                [info setValuesForKeysWithDictionary:dic];
                [self.musicInfosArray addObject:info];
            }
            
        } else {
            NSLog(@"数据写入失败  %@", error);
        }
        // 将数据反馈
        if (completion) {
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(_musicInfosArray, error);
            });
        }
    } fail:^(NSError *error) {
        if (completion) {
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
        }
    }];
}

// 获取分组个数
- (NSInteger)numberOfSections {
    return 1;
}

// 获取指定分组行数
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.musicInfosArray.count;
}

// 获取某个分区下某行的musicInfo
- (MusicInfo *)musicInfoForRowInIndexPath:(NSIndexPath *)indexPath {
    return self.musicInfosArray[indexPath.row];
}

#pragma mark - 配置播放音乐数据源相关操作
// 上一首数据源
- (MusicInfo *)musicInfoPreviousWithIndex:(NSInteger *)index {
    if (*index == 0) {
        *index = self.musicInfosArray.count - 1;
        return self.musicInfosArray[*index];
    }
    (*index)--;
    NSLog(@"上一首index = %ld", *index);
    return self.musicInfosArray[*index];
    
}

// 下一首数据源
- (MusicInfo *)musicInfoNextWithIndex:(NSInteger *)index {
    if (*index == self.musicInfosArray.count - 1) {
        *index = 0;
        return self.musicInfosArray[0];
    }
    (*index)++;
    NSLog(@"下一首index = %ld", *index);
    return self.musicInfosArray[*index];
    
}

// 随机数据源
- (MusicInfo *)musicInfoOfRandom:(NSInteger *)index {
    *index = arc4random() % self.musicInfosArray.count;
    NSLog(@"随机index = %ld", *index);
    return self.musicInfosArray[*index];
}

@end
