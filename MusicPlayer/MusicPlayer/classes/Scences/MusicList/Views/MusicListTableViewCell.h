//
//  MusicListTableViewCell.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicInfo.h"

@interface MusicListTableViewCell : UITableViewCell
/// 背景视图
@property (weak, nonatomic) IBOutlet UIView *backView;
/// 歌曲图片
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView;
/// 歌曲名称
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
/// 歌手名字
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
/// 专辑名称
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
/// 歌曲
@property (nonatomic, strong) MusicInfo *music;

@end
