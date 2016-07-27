//
//  MusicPlayViewController.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "AVPlayerManager.h"
#import <UIImageView+WebCache.h>
#import "MusicInfosHandle.h"
#import "NSString+TimeFormatter.h"
#import "RowLyricInfo.h"
#import "LyricInfoHandle.h"
#import "LricyTableViewCell.h"

// MusicInfoHandle的单例
#define kMusicInfosHandle [MusicInfosHandle sharedMusicInfosHandle]
// AVPlayerManager的单例
#define kAVPlayerManager [AVPlayerManager sharedAVPlayerManager]
// LyricInfoHandle的单例
#define kLyricInfoHandle [LyricInfoHandle sharedLyricInfoHandle]


@interface MusicPlayViewController ()<AVPlayerManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger lastIndex;  // 记录上一个歌词
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView;   // 音乐图片
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;  // 进度条
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;    // 模糊视图
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;   // 页面消失button
@property (weak, nonatomic) IBOutlet UITableView *tableView;    // 歌词列表
@property (weak, nonatomic) IBOutlet UILabel *currentPlayTimeLabel; // 当前播放时间标签
@property (weak, nonatomic) IBOutlet UILabel *remainTimeLabel;  // 剩余时间标签
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;    // 歌名标签
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;  // 歌手标签
@property (weak, nonatomic) IBOutlet UIButton *rewindButton;    // 上一首
@property (weak, nonatomic) IBOutlet UIButton *forwindButton; // 下一首
@property (weak, nonatomic) IBOutlet UIButton *playButton;  // 播放按钮
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;    // 音量滑动条
@property (weak, nonatomic) IBOutlet UIButton *singleLoopButton;    // 单曲循环按钮
@property (weak, nonatomic) IBOutlet UIButton *loopButton;  // 顺序循环按钮
@property (weak, nonatomic) IBOutlet UIButton *randomButton;  // 随机按钮
@end

@implementation MusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 先将musicImageView设置成圆角
    /**
     *  bug:在viewDidLoad方法中根据约束的控件设置视图的frame，会出现视图布局成功但是无法响应事件的问题
        解决办法：
        调用提前布局的方法 或者 将子视图frame设置放在viewDidAppear以后执行
     */
    _musicImageView.layer.cornerRadius = ([UIScreen mainScreen].bounds.size.width - 140) / 2;
    _musicImageView.layer.masksToBounds = YES;
    // 设置代理
    kAVPlayerManager.delegate = self;
    // 播放歌曲并设置view上所有子视图
    [self playAndSetUpViews];
    // 初始播放模式
    [self changeImageByLoopMode];
    // 设置volumeSlider
    _volumeSlider.minimumValue = 0.0;
    _volumeSlider.maximumValue = 1.0;
    _volumeSlider.value = [kAVPlayerManager volume];
    
#pragma mark - TableView
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    [_progressSlider setThumbImage:[UIImage imageNamed:@"thumb@2x"] forState:UIControlStateNormal];
    // 设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
// 播放歌曲并设置view上所有子视图
- (void)playAndSetUpViews {
    // 播放歌曲
    [kAVPlayerManager playWithUrl:_musicInfo.mp3Url currentIndex:self.index];
    
    // 改变播放按钮的状态
    [_playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    
    // 设置当前播放歌曲的相关信息
    _nameLabel.text = _musicInfo.name;
    _singerLabel.text = _musicInfo.singer;
    [_musicImageView sd_setImageWithURL:[NSURL URLWithString:_musicInfo.picUrl]];
//    [_blurImageView sd_setImageWithURL:[NSURL URLWithString:_musicInfo.blurPicUrl]];
    
    // 设置timeSlider
    _progressSlider.minimumValue = 0.0;
    _progressSlider.maximumValue = _musicInfo.duration / 1000;
    _progressSlider.value = 0;
    
    // 设置当前时间label 和 剩余时间label
    _currentPlayTimeLabel.text = @"00:00";
    _remainTimeLabel.text = [NSString getStringWithTime:_musicInfo.duration / 1000];
    
#pragma mark - 显示歌词部分
    // 歌词
    [kLyricInfoHandle lyricWithLyricString:_musicInfo.lyric];
    // 刷新视图
    [self.tableView reloadData];
    // 回到TableView顶部
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - 返回按钮
- (IBAction)disMissButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 进度条slider
- (IBAction)progressChange:(id)sender {
    [kAVPlayerManager seekToTime:_progressSlider.value];
}

#pragma mark - 上一首
- (IBAction)lastMusicAction:(id)sender {
    if (kAVPlayerManager.loopMode == LoopModeRandomMode) {
        _musicInfo = [kMusicInfosHandle musicInfoOfRandom:&_index];
    } else {
        _musicInfo = [kMusicInfosHandle musicInfoPreviousWithIndex:&_index];
    }
    [self playAndSetUpViews];
}

#pragma mark - 下一首
- (IBAction)nextMusicAction:(id)sender {
    if (kAVPlayerManager.loopMode == LoopModeRandomMode) {
        _musicInfo = [kMusicInfosHandle musicInfoOfRandom:&_index];
    } else {
        _musicInfo = [kMusicInfosHandle musicInfoNextWithIndex:&_index];
    }
    [self playAndSetUpViews];
}

#pragma mark - 播放 暂停
- (IBAction)playOrPauseAction:(id)sender {
    if (kAVPlayerManager.status == isPaused || kAVPlayerManager.status == isStoped) {
        [kAVPlayerManager play];
        [_playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    } else if (kAVPlayerManager.status == isPlaying) {
        [kAVPlayerManager pause];
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

#pragma mark - 音量调节
- (IBAction)changeVolumeValue:(id)sender {
    kAVPlayerManager.volume = _volumeSlider.value;
    
}

#pragma mark - 单曲循环
- (IBAction)singleLoopAction:(id)sender {
    // 记录播放模式
    kAVPlayerManager.loopMode = LoopModeSingleMond;
    [self changeImageByLoopMode];
}

#pragma mark - 顺序播放
- (IBAction)orderLoopAction:(id)sender {
    // 记录播放模式
    kAVPlayerManager.loopMode = LoopModeOrderMode;
    [self changeImageByLoopMode];
}

#pragma mark - 随机播放
- (IBAction)randomLoopAction:(id)sender {
    // 记录播放模式
    kAVPlayerManager.loopMode = LoopModeRandomMode;
    [self changeImageByLoopMode];
}

#pragma mark - 根据播放模式改变按钮图片
- (void)changeImageByLoopMode {
    switch (kAVPlayerManager.loopMode) {
        case LoopModeSingleMond:
            [_singleLoopButton setImage:[UIImage imageNamed:@"singleloop-s"] forState:UIControlStateNormal];
            [_loopButton setImage:[UIImage imageNamed:@"loop"] forState:UIControlStateNormal];
            [_randomButton setImage:[UIImage imageNamed:@"shuffle"] forState:UIControlStateNormal];
            break;
        case LoopModeOrderMode:
            [_singleLoopButton setImage:[UIImage imageNamed:@"singleloop"] forState:UIControlStateNormal];
            [_loopButton setImage:[UIImage imageNamed:@"loop-s"] forState:UIControlStateNormal];
            [_randomButton setImage:[UIImage imageNamed:@"shuffle"] forState:UIControlStateNormal];
            break;
        case LoopModeRandomMode:
            [_singleLoopButton setImage:[UIImage imageNamed:@"singleloop"] forState:UIControlStateNormal];
            [_loopButton setImage:[UIImage imageNamed:@"loop"] forState:UIControlStateNormal];
            [_randomButton setImage:[UIImage imageNamed:@"shuffle-s"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma mark - 根据播放模式取出下一首播放的music
- (void)getMusicByLoopMode {
    switch (kAVPlayerManager.loopMode) {
        case LoopModeOrderMode:
            _musicInfo = [kMusicInfosHandle musicInfoNextWithIndex:&_index];
            [self playAndSetUpViews];
            break;
        case LoopModeSingleMond:
            [self playAndSetUpViews];
            break;
        case LoopModeRandomMode:
            _musicInfo = [kMusicInfosHandle musicInfoOfRandom:&_index];
            [self playAndSetUpViews];
            break;
        default:
            NSLog(@"未知播放模式，请设置");
            break;
    }
}

#pragma mark - 实现代理方法
#pragma mark - 播放完成
- (void)playDidFinished {
    // 根据模式取出下一首播放的music
    [self getMusicByLoopMode];
}

#pragma mark - 定时器改变时间
- (void)changeTime:(CGFloat)time {
    // 改变silder的位置
    _progressSlider.value = time;
    _currentPlayTimeLabel.text = [NSString getStringWithTime:time];
    _remainTimeLabel.text = [NSString getStringWithTime:_musicInfo.duration / 1000 - time];
    // 转动imageView
    [UIView animateWithDuration:0.1 animations:^{
        _musicImageView.transform = CGAffineTransformRotate(_musicImageView.transform, 0.05);
    }];
    
#pragma mark - 显示当前播放歌词
    [self showLyricIsPlaying:time];
}

// 显示当前播放歌词
- (void)showLyricIsPlaying:(CGFloat)time {
    // 通过时间获取index
    NSInteger index = [kLyricInfoHandle indexForRowByTime:time];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LricyTableViewCell *showCell = [_tableView cellForRowAtIndexPath:indexPath];
    showCell.lyricLabel.textColor = [UIColor blackColor];

    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    // 清除所有其他cell上歌词的颜色
//    for (int i = 0; i < [kLyricInfoHandle numberofRowsInSection:0]; i++) {
//        if (i != index) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            LricyTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
//            cell.lyricLabel.textColor = [UIColor whiteColor];
//        }
//    }

    if (index == 0 || index == self.lastIndex) {
        self.lastIndex = index;
        return;
    } else {
        LricyTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastIndex inSection:0]];
        cell.lyricLabel.textColor = [UIColor whiteColor];
        self.lastIndex = index;
    }
    
    
}

#pragma mark - TableView显示歌词的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [kLyricInfoHandle numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [kLyricInfoHandle numberofRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LricyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LricyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    RowLyricInfo *lyric = [kLyricInfoHandle rowLyricForRowAtIndexPath:indexPath];
    cell.lyricLabel.text = lyric.rowLyrictring;
    cell.lyricLabel.textColor = [UIColor whiteColor];
    return cell;
}

@end
