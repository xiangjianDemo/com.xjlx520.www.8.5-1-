//
//  RollingAdvertisingTableViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/18.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "RollingAdvertisingTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface RollingAdvertisingTableViewController ()<CLLocationManagerDelegate>
{
    NSMutableDictionary *dic;
    NSString *identifier;
    UIActivityIndicatorView *activity;
    NSMutableArray *deal;
    
    long page;
//    菜单
    NSArray *_titleArray;
    NSArray *_leftArray;
    NSArray *_rigthArray;
    
//    菜单选中的分类
    NSArray *_selectArray;
    CLLocationManager *locationManager;
//    搜索
    NSString *keyword;
//    首页调用
    NSString *cate_id;
    
}
@property (nonatomic, retain)CLLocationManager *_locationManager;
@property (nonatomic, retain)UITableView *tableView1;

@end

@implementation RollingAdvertisingTableViewController
@synthesize keyWord = keyword;
@synthesize cate_id = cate_id;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLoction = [locations lastObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lat = [[NSString alloc]initWithFormat:@"%g",currentLoction.coordinate.latitude];
    [userDefaults setObject:lat forKey:@"m_latitude"];
    NSString *lng = [[NSString alloc]initWithFormat:@"%g",currentLoction.coordinate.longitude];
    [userDefaults setObject:lng forKey:@"m_longitude"];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSString *lat = [[NSString alloc] initWithFormat:@"%g",
                     newLocation.coordinate.latitude];
    [userDefaultes setObject:lat forKey:@"m_latitude"];
    NSString *lng = [[NSString alloc] initWithFormat:@"%g",
                     newLocation.coordinate.longitude];
    [userDefaultes setObject:lng forKey:@"m_longitude"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"滚动广告";
    
    self.tableView1 = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.view addSubview:self.tableView1];
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    locationManager.distanceFilter = kCLHeadingFilterNone;
    [locationManager startUpdatingLocation];
    
    
    activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [activity setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2)];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [activity hidesWhenStopped];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
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

    return 10;
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
