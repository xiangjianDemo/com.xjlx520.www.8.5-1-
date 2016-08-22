//
//  CenterViewTableViewController.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/12.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "CenterViewTableViewController.h"
#import "UIView+SDExtension.h"
#import "Content_TableViewCell.h"
#import "LoginViewController.h"
#import "centerHeardView.h"
#import "CreateLiveViewController.h"
@interface CenterViewTableViewController ()<UITableViewDelegate>

@end

@implementation CenterViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    self.navigationController.navigationBarHidden = YES;
    self.title = @"我";
    self.tableView.showsVerticalScrollIndicator = NO;// 滑动条隐藏
    
    //    设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:104.0/255.0 blue:53.0/255.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = YES;
    
    centerHeardView *heardView = [[centerHeardView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScteenHeight/3.5)];
    [heardView.LoginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = heardView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
               case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        case 2:
        {
            return 3;
        }
            break;
            
        default:{
            return 0;
            break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return kScteenHeight/16;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   NSString *cellID = @"cellID";
    
        Content_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[Content_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        if (indexPath.section == 0) {
            if (cell.textLabel.text !=nil) {
                cell.textLabel.text = nil;
            }
            NSArray *title = @[@"我的广告",@"我的等级",@"完善资料"];
                       cell.textLabel.text = title
            [indexPath.row];
        }if (indexPath.section == 1) {
            if (cell.textLabel.text != nil) {
                cell.textLabel.text = nil;
            }
            NSArray *title = @[@"我的收益",@"我的钱包",@"我的抽奖机会"];
            
                        cell.textLabel.text = title[indexPath.row];
            
        }if (indexPath.section == 2) {
            if (cell.textLabel.text != nil) {
                cell.textLabel.text = nil;
            }
            NSArray *title = @[@"帮助与反馈",@"创建房间",@"设置"];
                        cell.textLabel.text = title[indexPath.row];
            
        }
        return cell;
    
    
    return nil;
}


- (void)action:(UIButton *)sender{
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            [self firstSectionMethod:indexPath];
             break;
        }
        case 1:
        {
            [self secondSectionMethod:indexPath];
            break;
        }

        case 2:
        {
            [self thirdSectionMethod:indexPath];
            break;
        }
        default:
            break;
    }
}
-(void)firstSectionMethod:(NSIndexPath*)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
}
-(void)secondSectionMethod:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
           
            
            break;
        }
        default:
            break;
    }

}
-(void)thirdSectionMethod:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            NSLog(@"hello word");
            
            CreateLiveViewController *createrLive = [[CreateLiveViewController alloc]init];
            [self.navigationController pushViewController:createrLive animated:YES];
            break;
        }
        case 2:
        {
            
            break;
        }
        default:
            break;
    }
    
}

@end
