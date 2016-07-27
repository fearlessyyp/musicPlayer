//
//  MusicInfo.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject

/// 播放路径
@property (nonatomic, copy) NSString *mp3Url;
/// 
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *blurPicUrl;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, assign) NSInteger duration;  // 毫秒
@property (nonatomic, copy) NSString *artists_name;
@property (nonatomic, copy) NSString *lyric;
@end
