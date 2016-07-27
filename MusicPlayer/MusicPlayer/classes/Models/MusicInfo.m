//
//  MusicInfo.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo

// 防崩
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.Id = (NSInteger)value;
    }
}

@end
