//
//  ClassAdsViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/22.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "ClassAdsViewController.h"
#import <CoreLocation/CoreLocation.h>
//#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "TheAFNetWorking.h"
#import "ClassAdsDetailTableViewController.h"
#import "DropdownMenu.h"
#import "JSDropDownMenu.h"
#import <SDAutoLayout.h>

@interface ClassAdsViewController ()<UITableViewDelegate,UITableViewDataSource,SDWebImageManagerDelegate,dropdownDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate>
{
    //    调用首页
    NSString *lx_id;
    //    搜索
    NSString *Keyword;
//    等待小转盘
    UIActivityIndicatorView *activity;
    
    NSMutableArray *classArrayData;
    
    NSArray *classArray;
    
    NSMutableDictionary *dicData;
    
    int i;
    
//    菜单1
    NSArray *_titleArray;
    NSArray *_leftArray;
    NSArray *_rightArray;
    
    DropdownMenu *dropdown;
    
//    菜单2
    JSDropDownMenu *JsdMenu;
    
    NSMutableArray *_data;
    
    NSInteger _currentDataIndex;
    
    NSMutableArray *dataArray;
    NSMutableArray *dataName;
    
    
}

@property (nonatomic, retain)CLLocationManager *locationManager;
@property (nonatomic, retain)UITableView *tableView;

@end


@implementation ClassAdsViewController

@synthesize Keyword = Keyword;
@synthesize lx_id = lx_id;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类广告";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];// 进度轮的大小
    [activity setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];// 进度轮的中心
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];// 进度轮的现实类型
    [activity hidesWhenStopped];
    [self.view addSubview:activity];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    [self postClassAdsdata];
    [self postClassifiedAdData];
    [self postClassificationData];
    
    
    [self menuData];
//    菜单一
    dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
    //                dropdown.view.backgroundColor=
    dropdown.delegate = self;
    
//    [self.view addSubview:dropdown.view];
//菜单2
    
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐",@"烧烤"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游",@"自驾游"];
    NSArray *hello = @[@"hello",@"nice",@"good",@"hehe",@"word",@"moning"];
    
    _data = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}, @{@"title":@"hello",@"data":hello},nil];
//    _data = [NSMutableArray arrayWithObjects:@{@"title":travel,@"data":food}, nil];
    
    JsdMenu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    JsdMenu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    JsdMenu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    JsdMenu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    JsdMenu.dataSource = self;
    JsdMenu.delegate = self;
    
    [self.view addSubview:JsdMenu];
    
}


#pragma mark ======下拉菜单  代理方法＝＝＝＝＝＝
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 1;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column == 0) {
        return _currentDataIndex;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        if (leftOrRight == 0) {
            return _data.count;
        }else{
            NSDictionary *menuDic = [_data objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data" ]count];
        }
    }
   
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    switch (column) {
        case 0:
            return [[_data[0]objectForKey:@"data"]objectAtIndex:0];
            break;
            
        default:
            return nil;
            break;
    }
  
    
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.leftOrRight == 0) {
            NSDictionary *menuDic = [_data objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
            
        }else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"]objectAtIndex:indexPath.row];
        }
    }
    return nil;
    
}


- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.leftOrRight == 0) {
            _currentDataIndex = indexPath.row;
            return;
        }
        
    }
    
}



- (void)postClassAdsdata{
    
    NSString *url = @"http://219.151.12.30:8081/admin/webapi/Handlerlx_guanggao.ashx";
    
    NSDictionary *dicc = @{@"flag":@"tb_lx_guanggao_query",@"guanggao_type":lx_id,@"pags":@"1",@"page":@"10"};
    [TheAFNetWorking getHttpsURL:url parameters:dicc AndSuccess:^(NSArray *dic) {
//        NSString *resonseString = [[NSString alloc]initWithData:dic encoding:NSUTF8StringEncoding];
        
        classArrayData = [NSMutableArray array];
        [classArrayData addObject:dic];
//        classArrayData = [NSJSONSerialization JSONObjectWithData:dic options:NSJSONReadingMutableContainers error:nil];
//        classArrayData = [NSJSONSerialization JSONObjectWithStream:dic options:NSJSONReadingMutableContainers error:nil];
        [self.tableView reloadData];
        NSLog(@"显示分类广告：%@",classArrayData);
        
        
    } orfailure:^{
        
    } showHUD:YES];
    
    
//    AFHTTPRequestOperationManager *httpmanager = [AFHTTPRequestOperationManager manager];
//    httpmanager.requestSerializer = [AFJSONRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer = [AFJSONResponseSerializer new];
//    httpmanager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    
////    [httpmanager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        NSLog(@"显示分类广告：%@",responseObject);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSLog(@"显示分类广告错误：%@",error);
////    }];
//    
//    [httpmanager GET:url parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
////        NSString *resonseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        classArrayData = [NSMutableArray array];
//        [classArrayData addObject:responseObject];
//        classArrayData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        [self.tableView reloadData];
//        NSLog(@"显示分类广告：%@",classArrayData);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"显示分类广告错误：%@",error);
//
//    }];
}


// 请求分类推荐广告
- (void)postClassifiedAdData{
    NSString *url = @"http://219.151.12.30:8081/admin/webapi/Handlerlx_guanggao.ashx?flag=tb_lx_guanggao_recommend";
    NSDictionary *paramers = @{@"guanggao_type":lx_id};
    
    [TheAFNetWorking getHttpsURL:url parameters:paramers AndSuccess:^(NSArray *dic) {
        NSLog(@"%@",dic);
    } orfailure:^{
        
    } showHUD:YES];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:paramers success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"分类推荐广告：%@",responseObject);
//        classArray = responseObject;
//        NSLog(@"%@",classArray);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"推荐广告请求失败：%@",error);
//    }];
}
// 请求分级数据
- (void)postClassificationData{
    NSString *url = @"http://219.151.12.30:8081/admin/webapi/Handler_advertisement_fenl.ashx?flag=advertisement_details";
    NSDictionary *paramers = @{@"fenl_type":lx_id};
    [TheAFNetWorking getHttpsURL:url parameters:paramers AndSuccess:^(NSArray *dic) {
        
    } orfailure:^{
        
    } showHUD:YES];
    
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    [manger GET:url parameters:paramers success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"分级请求成功：%@",responseObject);
//        NSMutableArray *array = responseObject;
//        dataArray = [@[]mutableCopy];
//        for (int index = 0; index < array.count; index++) {
//            if ([array[index][@"class_layer"]isEqualToString:@"2"]) {
//                NSString *str = array[index][@"lx_name"];
//                [dataArray addObject:str];
//                
//                NSLog(@"%@",dataArray);
//                if ([array[index][@"class_layer"]isEqualToString:@"3"]&&[array[index][@""]isEqualToString:@""]) {
//                    
//                }
//            }
//            
//        }
//        
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"分级请求失败：%@",error);
//    }];
}

// 分级数据
- (void)menuData{
    [self menuTitleArray];
    [self menuftArray];
}
// 下拉标题
- (void)menuTitleArray{
    _titleArray = @[@"分级"];
}
// 左列表为空，则为 当下啦菜单  可以根据需要传值
- (void)menuftArray{
//    NSMutableArray *leftArray = [NSMutableArray array];
//    NSMutableArray *rightArray = [NSMutableArray array];
    
    _leftArray = dataArray;
    _rightArray = @[@"nihao",@"wohao",@"dajiahao",@"hello"];
}

//实现代理，返回选中的下标，若左边没有列表，则返回0
- (void)dropdownSelectedLeftIndex:(NSArray *)selected{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark===== Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return classArrayData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}



// 表尾
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 145/2)];
        view.backgroundColor = [UIColor orangeColor];
        
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 145/2, [UIScreen mainScreen].bounds.size.width, 145/2)];
        view1.backgroundColor = [UIColor blueColor];
        
        return view;
        return view1;
        
        
    }
    
    
    return NULL;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 185)];
        view.backgroundColor = [UIColor orangeColor];
        
        for (i = 0; i<classArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 45+(58+15)*i, 88, 58)];
            imageView.userInteractionEnabled = YES;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 4.0;
//            imageView.image = [UIImage imageNamed:@"wo"];
            NSString *httpUrl = @"http://219.151.12.30:8081";
            NSString *url = [[NSString alloc]initWithFormat:@"%@%@",httpUrl,classArray[i][@"lx_picture"]];
            
//                      [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
            
            [view addSubview:imageView];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(94, 40+(70+5)*i, [UIScreen mainScreen].bounds.size.width-94, 30)];
            nameLabel.text = classArray[i][@"lx_name"];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.font = [UIFont boldSystemFontOfSize:10];
            nameLabel.textColor = [UIColor grayColor];
            [view addSubview:nameLabel];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.frame = CGRectMake(0, (145/2+1)*i, [UIScreen mainScreen].bounds.size.width, 145/2);
            [button addTarget:self action:@selector(anction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 6+i;
            [view addSubview:button];
        }
        
        return view;
        
    }
    return NULL;
}

- (void)anction:(UIButton *)sender{
   
    
    switch (sender.tag ) {
        case 6:
        {
            ClassAdsDetailTableViewController *detail = [[ClassAdsDetailTableViewController alloc]init];
            detail.lx_id = classArray[0][@"lx_id"];
            detail.title1 = classArray[0][@"lx_name"];
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
            
        case 7:
        {
            ClassAdsDetailTableViewController *detail = [[ClassAdsDetailTableViewController alloc]init];
            detail.lx_id = classArray[1][@"lx_id"];
            detail.title1 = classArray[1][@"lx_name"];
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
            
        default:
            break;
    }

   
}

// 表头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 185;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 5, 88, 58)];
            imageView.userInteractionEnabled = YES;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 4.0;
            imageView.image = [UIImage imageNamed:@"wo"];
//            imageView.backgroundColor = [UIColor orangeColor];
            
            NSString *httpUrl = @"http://219.151.12.30:8081";
            NSString *url = [[NSString alloc]initWithFormat:@"%@%@",httpUrl,classArrayData[indexPath.row][@"lx_picture"]];
            
           
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
            
            [cell.contentView addSubview:imageView];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(94, 0, [UIScreen mainScreen].bounds.size.width-94, 30)];
            nameLabel.text = classArrayData[indexPath.row][@"lx_name"];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.font = [UIFont boldSystemFontOfSize:10];
            nameLabel.textColor = [UIColor grayColor];
//            nameLabel.backgroundColor = [UIColor orangeColor];
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:nameLabel];
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


//UItableView被选中时调用的方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassAdsDetailTableViewController *detail = [[ClassAdsDetailTableViewController alloc]init];
    detail.lx_id = [classArrayData[indexPath.row]objectForKey:@"lx_id"];
    detail.title1 = [classArrayData[indexPath.row]objectForKey:@"lx_name"];
    [self.navigationController pushViewController:detail animated:YES];
    
}


/*{
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
