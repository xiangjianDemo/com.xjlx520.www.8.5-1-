//
//  ClassAdsDetailTableViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/27.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "ClassAdsDetailTableViewController.h"
#import "TheAFNetWorking.h"
#import "UIImageView+WebCache.h"
@interface ClassAdsDetailTableViewController ()<UITableViewDelegate,UITableViewDataSource,SDWebImageManagerDelegate>
{
    NSString *lx_id;
    NSString *title1;
    NSArray *classArrayData;
    NSMutableArray *arr;
    NSString *string;
    NSDictionary *dic1;
    
    NSString *nameString1;
    NSString *nameString2;
    NSString *nameString3;
    NSString *nameString4;
}

@end

@implementation ClassAdsDetailTableViewController
@synthesize lx_id = lx_id;
@synthesize title1 = title1;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = title1;
    
    [self postClassAdsDetaildata];
//    [self action];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(arc4random()%320, arc4random()%480, 64, 80);
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"hongbao"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    NSUserDefaults *userDe1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"first_Invitation_code"];
    nameString1 = [NSString stringWithFormat:@"%@",userDe1];
    NSUserDefaults *userDe2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"Second_Invitation_code"];
    nameString2 = [NSString stringWithFormat:@"%@",userDe2];
    NSUserDefaults *userDe3 = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_full_name"];
    nameString3 = [NSString stringWithFormat:@"%@",userDe3];
    NSUserDefaults *userDe4 = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    nameString4 = [NSString stringWithFormat:@"%@",userDe4];
    
    NSLog(@"%@%@%@%@",nameString1,nameString2,nameString3,nameString4);
    
}

- (void)postClassAdsDetaildata{
    
    NSString *url = [TheAFNetWorking httpURLStr:@"admin/webapi/Handlerlx_guanggao.ashx"];
    
    NSDictionary *dicc = @{@"flag":@"tb_lx_guanggao_show",@"lx_id":lx_id};
    [TheAFNetWorking getHttpsURL:url parameters:dicc AndSuccess:^(NSArray *dic) {
                classArrayData = [NSArray array];
//                [classArrayData addObject:dic];
        classArrayData = dic;
//                classArrayData = [NSJSONSerialization JSONObjectWithData:dic options:NSJSONReadingMutableContainers error:nil];
                [self.tableView reloadData];

    } orfailure:^{
        
    } showHUD:YES];
//    
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
//    [httpmanager GET:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        //        NSString *resonseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        classArrayData = [NSMutableArray array];
//        [classArrayData addObject:responseObject];
//        classArrayData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        [self.tableView reloadData];
//        NSLog(@"广告详细页面：%@",classArrayData);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"广告详细页面错误：%@",error);
//        
//    }];
}

- (void)showAlertWithMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抢红包" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
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

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
    }else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.section) {
        case 0:
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 0.0;
            
            NSString *httpUrl = @"http://219.151.12.30:8081";
            NSString *url = [[NSString alloc]initWithFormat:@"%@%@",httpUrl,classArrayData[indexPath.row][@"lx_picture"]];
            if (url) {
//                [[SDWebImageManager sharedManager]downloadWithURL:[NSURL URLWithString:url] delegate:self];
                
                }
//            [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
            [cell.contentView addSubview:imageView];
            
            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(arc4random()%320, arc4random()%480, 50, 80);
//            [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//            button.backgroundColor = [UIColor orangeColor];
//            [imageView addSubview:button];
            
            
            return cell;
        }
            
            break;
            
        case 1:
        {
            
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)action:(UIButton *)sender{
    
    
    NSString *url = [TheAFNetWorking httpURLStr:@"http://219.151.12.30:8081/admin/webapi/Handler_Winning_list.ashx?flag=dwtype"];
    NSDictionary *paramers = @{@"ld_name":@"越野",@"ld_name_id":@"14",@"user_id":@"1",@"user_name":@"何建雄",@"types":@"A",@"Secondinvitationid":@"0",@"firstinvitationid":@"0"};
    
    [TheAFNetWorking postHttpsURL:url parameters:paramers AndSuccess:^(NSArray *dic) {
        
        NSLog(@"%@",dic);
          [self showAlertWithMessage:@"恭喜你获得:%@"];
    } orfailure:^{
        
    } showHUD:YES];
//    
//    AFHTTPRequestOperationManager *httpmanager = [AFHTTPRequestOperationManager manager];
//    
//    httpmanager.requestSerializer = [AFJSONRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer = [AFJSONResponseSerializer new];
//    httpmanager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
////    [httpmanager GET:url parameters:paramers success:^(AFHTTPRequestOperation *operation, id responseObject) {
////         arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
////        NSLog(@"返回红包：%@",arr);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSLog(@"红包错误：%@",error);
////    }];
//
//    [httpmanager POST:url parameters:paramers success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"返回红包：%@",string);
//        [self showAlertWithMessage:@"恭喜你获得:%@"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"红包错误：%@",error);
//    }];
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
