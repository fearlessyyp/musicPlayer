//
//  MusicListRefreshFailView.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "MusicListRefreshFailView.h"

@implementation MusicListRefreshFailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"refreshFail"];

    self.backImageView = imageView;
    [self addSubview:imageView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 500, 214, 30);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"重新刷新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    [self addSubview:button];
    
}

- (void)buttonAction:(UIButton *)sender {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

@end
