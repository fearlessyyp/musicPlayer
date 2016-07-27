//
//  MusicListTableViewCell.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "MusicListTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MusicListTableViewCell

// cell的子视图进行赋值
- (void)setMusic:(MusicInfo *)music {
    if (_music != music) {
        _music = nil;
        _music = music;
        _musicNameLabel.text = music.name;
        _albumNameLabel.text = music.album;
        _singerNameLabel.text = music.singer;
        [_musicImageView sd_setImageWithURL:[NSURL URLWithString:music.picUrl] placeholderImage:[UIImage imageNamed:@"baekhyun"]];
    }
}



@end
