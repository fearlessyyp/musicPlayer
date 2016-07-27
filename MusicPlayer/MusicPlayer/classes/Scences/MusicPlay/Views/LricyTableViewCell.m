//
//  LricyTableViewCell.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/15.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "LricyTableViewCell.h"

@implementation LricyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _lyricLabel = [[UILabel alloc] init];
        _lyricLabel.numberOfLines = 0;
        _lyricLabel.textAlignment = NSTextAlignmentCenter;
        _lyricLabel.font = [UIFont systemFontOfSize:15.0];
        _lyricLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_lyricLabel];
        // 取消cell的点击状态
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/// 计算cell高度
+ (CGFloat)heightForCellWithLyricString:(NSString *)lyricString {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100000);
    CGRect rect = [lyricString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.lyricLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);                                                                                                     
}

@end
