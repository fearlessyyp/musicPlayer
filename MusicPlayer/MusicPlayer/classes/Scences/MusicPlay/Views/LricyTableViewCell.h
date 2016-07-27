//
//  LricyTableViewCell.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/15.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LricyTableViewCell : UITableViewCell
/// 显示歌词
@property (nonatomic, strong) UILabel *lyricLabel;
/// 计算cell高度
+ (CGFloat)heightForCellWithLyricString:(NSString *)lyricString;
@end
