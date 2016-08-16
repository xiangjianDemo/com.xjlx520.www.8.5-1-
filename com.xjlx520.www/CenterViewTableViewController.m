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
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    switch (section) {
        case 0:
        {
            return 1;
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
        case 3:
        {
            return 2;
        }
            break;
            
        default:{
            return 0;
            break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kScteenHeight/3.5;
    }
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
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.5)/2, kScteenHeight/50, kScreenWidth/4.5, kScreenWidth/4.5)];
//        imageView.backgroundColor = [UIColor grayColor];
        imageView.image = [UIImage imageNamed:@"tab_3_normal"];
//        imageView.contentMode = UIViewContentModeCenter;
        imageView.tag = 10;
        imageView.userInteractionEnabled = YES;
        [cell.contentView addSubview:imageView];
       
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame = CGRectMake((kScreenWidth-kScreenWidth/5)/2, kScteenHeight/6.2, kScreenWidth/5, kScreenWidth/12.5);
        loginButton.backgroundColor = [UIColor orangeColor];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        loginButton.tag = 10;
        [cell.contentView addSubview:loginButton];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, kScteenHeight/7, 80, 25)];
        [cell.contentView addSubview:label];
        
        return cell;
        
    }else{
        
        Content_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[Content_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        if (indexPath.section == 1) {
            if (cell.textLabel.text !=nil) {
                cell.textLabel.text = nil;
            }
            NSArray *title = @[@"我的广告",@"我的等级",@"完善资料"];
                       cell.textLabel.text = title
            [indexPath.row];
        }if (indexPath.section == 2) {
            if (cell.textLabel.text != nil) {
                cell.textLabel.text = nil;
            }
            NSArray *title = @[@"我的收益",@"我的钱包",@"我的抽奖机会"];
            
                        cell.textLabel.text = title[indexPath.row];
            
        }if (indexPath.section == 3) {
            if (cell.textLabel.text != nil) {
                cell.textLabel.text = nil;
            }
            NSArray *title = @[@"帮助与反馈",@"设置"];
                        cell.textLabel.text = title[indexPath.row];
            
        }
        return cell;
    }
    
    return nil;
}


- (void)action:(UIButton *)sender{
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
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
