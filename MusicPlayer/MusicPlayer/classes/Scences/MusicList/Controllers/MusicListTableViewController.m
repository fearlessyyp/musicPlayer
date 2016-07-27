//
//  MusicListTableViewController.m
//  MusicPlayer
//
//  Created by GXSS on 16/3/13.
//  Copyright © 2016年 yyp. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "MusicListTableViewCell.h"
#import "MusicInfosHandle.h"
#import "Music_List_Url.h"
#import "MusicPlayViewController.h"
#import <MBProgressHUD.h>
#import "MusicListRefreshFailView.h"

#define kMusicInfosHandle [MusicInfosHandle sharedMusicInfosHandle]
#define kMusicCellID @"cell"
@interface MusicListTableViewController ()

@end

@implementation MusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"音乐列表";
    
    // 请求需要的数据
    [self requestData];
    
    // 显示菊花
    [self showHUD];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicListTableViewCell" bundle:nil] forCellReuseIdentifier:kMusicCellID];
    
    
}
#pragma mark - 显示菊花
- (void)showHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"歌曲信息正在加载...";
}

#pragma mark - 隐藏菊花
- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - 请求需要的数据
- (void)requestData {
    __weak typeof(self)weakSelf = self;
    [kMusicInfosHandle getMusicInfoWithUrl:MUSIC_LIST_URL completion:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"请求失败 %@", error);
            [self hideHUD];
            // 可以设置背景图，提示用户重新加载
            MusicListRefreshFailView *refreshFailView = [[MusicListRefreshFailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            refreshFailView.refreshBlock = ^void () {
                [weakSelf requestData];
                [[weakSelf.view subviews].lastObject removeFromSuperview];
                [weakSelf showHUD];
            };
            [self.view addSubview:refreshFailView];
        } else {
            // 刷新数据
            [weakSelf.tableView reloadData];
            [self hideHUD];
       
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [kMusicInfosHandle numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [kMusicInfosHandle numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMusicCellID forIndexPath:indexPath];
    
    cell.music = [kMusicInfosHandle musicInfoForRowInIndexPath:indexPath];
    
    return cell;
}

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 143;
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicPlayViewController *musicPlayVC = [[MusicPlayViewController alloc] init];
    MusicInfo *musicInfo = [kMusicInfosHandle musicInfoForRowInIndexPath:indexPath];
    musicPlayVC.musicInfo = musicInfo;
    musicPlayVC.index = indexPath.row;
    [self presentViewController:musicPlayVC animated:YES completion:nil];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
