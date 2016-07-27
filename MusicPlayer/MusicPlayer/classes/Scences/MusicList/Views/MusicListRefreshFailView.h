//
//  MusicListRefreshFailView.h
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)();

@interface MusicListRefreshFailView : UIView
/// 背景图
@property (nonatomic, strong) UIImageView *backImageView;
/// 重新刷新按钮
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) RefreshBlock refreshBlock;

@end
