//
//  RowLyricInfo.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/15.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RowLyricInfo : NSObject

// 歌词的时间
@property (nonatomic, assign) CGFloat time;
// 单行歌词
@property (nonatomic, strong) NSString *rowLyrictring;

// 自定义初始化方法
- (instancetype)initWithRowLyricString:(NSString *)rowLyric
                               andTime:(CGFloat)time;

// 遍历构造器
+ (instancetype)rowLyricWithRowLyricString:(NSString *)rowLyric
                                   andTime:(CGFloat)time;

@end
