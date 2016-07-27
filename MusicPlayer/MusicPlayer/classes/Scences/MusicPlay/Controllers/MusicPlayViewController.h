//
//  MusicPlayViewController.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicInfo.h"


@interface MusicPlayViewController : UIViewController
/// musicInfo接收点击的音乐对应的信息
@property (nonatomic, strong) MusicInfo *musicInfo;
/// 当前播放歌曲对应的下标
@property (nonatomic, assign) NSInteger index;



@end
