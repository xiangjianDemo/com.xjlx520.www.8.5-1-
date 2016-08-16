//
//  PushAdvertisingTableViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/18.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "PushAdvertisingTableViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TheAFNetWorking.h"


@interface PushAdvertisingTableViewController ()<UITableViewDelegate,UITableViewDataSource,SDWebImageManagerDelegate>
{
    NSMutableArray *classArrayData;
    NSArray *arr;
}
@end

@implementation PushAdvertisingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推送广告";
    
    [self postPushAdsdata];
}

- (void)postPushAdsdata{
    NSString *url = [TheAFNetWorking httpURLStr:@"admin/webapi/Handlerlx_guanggao.ashx?flag=tb_lx_guanggao_mytuijian"];
    
    NSDictionary *dicc = @{@"useraihao":@"29",@"userage":@"25",@"usersex":@"0",@"usermoney":@"0.0000",@"pags":@"1",@"page":@"10"};
   
    [TheAFNetWorking  postHttpsURL:url  parameters:dicc AndSuccess:^(NSArray *dic) {
        
        arr = [NSArray array];
        arr = dic;
        NSLog(@"用户推荐请求成功%@",arr);
        [self.tableView reloadData];
    } orfailure:^{
        
    } showHUD:YES];
    
//    [TheAFNetWorking getHttpsURL:url parameters:dicc AndSuccess:^(NSArray *dic) {
//        NSLog(@"用户推荐请求成功%@",dic);
//    } orfailure:^{
//        
//    } showHUD:YES];
    
//    AFHTTPRequestOperationManager *httpmanager = [AFHTTPRequestOperationManager manager];
//    httpmanager.requestSerializer = [AFJSONRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer = [AFJSONResponseSerializer new];
//    httpmanager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    
//    //    [httpmanager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    //        NSLog(@"显示分类广告：%@",responseObject);
//    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    //        NSLog(@"显示分类广告错误：%@",error);
//    //    }];
//    
////    [httpmanager GET:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        
////        
////        //        NSString *resonseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
////        
////        classArrayData = [NSMutableArray array];
////        [classArrayData addObject:responseObject];
////        classArrayData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
////        [self.tableView reloadData];
////        NSLog(@"显示推送广告：%@",classArrayData);
////        
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSLog(@"显示推送广告错误：%@",error);
////        
////    }];
//    
////    [httpmanager GET:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        
////        NSLog(@"推送广告：%@",responseObject);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        
////        NSLog(@"%@",error);
////    }];
//    
//    [httpmanager POST:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"推荐广告：%@",arr);
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 5, 88, 58)];
    imageView.userInteractionEnabled = YES;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 4.0;
    imageView.image = [UIImage imageNamed:@"wo"];
    //            imageView.backgroundColor = [UIColor orangeColor];
    
    NSString *httpUrl = @"http://219.151.12.30:8081";
    NSString *url = [[NSString alloc]initWithFormat:@"%@%@",httpUrl,arr[indexPath.row][@"lx_picture"]];
    
    if (url) {
//        [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:url] delegate:self];
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"hongbao"]];
    [cell.contentView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(94, 0, [UIScreen mainScreen].bounds.size.width-94, 30)];
    nameLabel.text = arr[indexPath.row][@"lx_name"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont boldSystemFontOfSize:10];
    nameLabel.textColor = [UIColor grayColor];
    //            nameLabel.backgroundColor = [UIColor orangeColor];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:nameLabel];
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
