//
//  ViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "homeScrollViewTableViewCell.h"
#import "homeClassifiedAdsTableViewCell.h"
#import "throughOurTableViewCell.h"
//#import "AFNetworking.h"


// 添加这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
//添加这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface HomeViewController ()<SDCycleScrollViewDelegate,homeScrollViewTableViewCellDelegate,homeClassifiedAdsTableViewCellDelegate,throughOurTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //    滚动视图
    NSArray *imageArray;// 图片数组
    SDCycleScrollView *cycleScrollView;//自定义滚动视图
    
    
}


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"首页";
    NSLog(@"hello word");
    
    [self statusView];
    
    
//    [self initCycleScrollView];
    
    [self reach];
}


- (void)viewWillAppear:(BOOL)animated{
//    [self ];
}


// *****请求数据
- (void)reach{
    NSString *httpUrl = @"http://xxxx.com/webapi/Handler_tb_advertisement.ashx";
    NSString *httpArg = @"flag= advertisement_details";
    
    [self request: httpUrl withHttpArg: httpArg];

}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    
    [request setHTTPMethod: @"GET"];
    
//    [request addValue: @"您自己的apikey" forHTTPHeaderField: @"apikey"];
    
//    [NSURLConnection sendAsynchronousRequest: request
//                                       queue: [NSOperationQueue mainQueue]
//     
//                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//                               if (error) {
//                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//                                   NSLog(@"data:%@",data);
//                                   
//                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
//                               }
//                           }];
    }



#pragma mark 滚动视图
- (void)initCycleScrollView{
    
    imageArray = @[[UIImage imageNamed:@"image0"],[UIImage imageNamed:@"image1"],[UIImage imageNamed:@"image2"],[UIImage imageNamed:@"image3"],[UIImage imageNamed:@"image3"]];
    
    
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 58, ScreenWidth, ScreenHeight/4) imagesGroup:imageArray];
    cycleScrollView.delegate = self;
    cycleScrollView.dotColor = [UIColor greenColor];//分页控制小图标颜色
    cycleScrollView.pageControlDotSize = CGSizeMake(5, 5);//分页控件小图标大小
    cycleScrollView.placeholderImage = [UIImage imageNamed:@""];//占位图，用于网络未加载到图片时
    [self.view addSubview:cycleScrollView];
    
}

#pragma mark SDCycleScrollViewDelegatedaili

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    // 监听点击滚动视图方法
    
}

- (void)didTouchSDCycle:(SDCycleScrollView *)SDCycle andTableViewCell:(homeScrollViewTableViewCell *)cell{
    
}

// 状态栏上视图
-(void)statusView{
    
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:statusView];
    self.navigationItem.rightBarButtonItem= rightItem;
    
//    定位按钮
    UIButton * locationButton=[[UIButton alloc] initWithFrame:CGRectMake(34, 2, 26, 26)];
    //    jsbt.backgroundColor=[UIColor orangeColor];
    locationButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [locationButton setTitle:@"定位" forState:UIControlStateNormal];
    UIImage *sImg=[UIImage imageNamed:@"放大镜" ];
    sImg= [sImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [locationButton setBackgroundImage:sImg forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    locationButton.layer.masksToBounds=YES;
    locationButton.layer.cornerRadius=3;
    [locationButton addTarget:self action:@selector(ActiondoSearch_check:) forControlEvents:UIControlEventTouchUpInside];
//    搜索按钮
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenHeight-34, 2, 26, 26)];
    searchButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    UIImage *sImg1=[UIImage imageNamed:@"放大镜" ];
    sImg= [sImg1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [searchButton setBackgroundImage:sImg forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.layer.masksToBounds=YES;
    searchButton.layer.cornerRadius=3;
    [searchButton addTarget:self action:@selector(ActiondoSearch_check:) forControlEvents:UIControlEventTouchUpInside];
//  添加按钮
    [statusView addSubview:locationButton];
    [statusView addSubview:searchButton];
    
    
}


//homeScrollViewTableViewCellDelegate 代理方法
- (void)didTouchButton:(UIButton *)button andTableViewCell:(homeScrollViewTableViewCell *)cell{
    
}

//homeClassifiedAdsTableViewCellDelegate 代理方法
- (void)didTouchButton:(UIButton *)button addTableViewCell:(homeClassifiedAdsTableViewCell *)cell{
    
}

//throughOurTableViewCellDelegate 代理方法
- (void)didTouchbutton:(UIButton *)button addTableViewCell:(throughOurTableViewCell *)cell{
    
}

#pragma mark tabBiew代理方法

//****cell组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
//****cell 的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    return 1;
}

// 初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *homeScroViewCellID = @"homeScroViewCellID";
    NSString *homeClassfiedCellID = @"homeClassfiedCellID";
    NSString *throughOurCell = @"throughOurCell";
    
    switch (indexPath.section) {
        case 0:
        {
            homeScrollViewTableViewCell *cell = [[homeScrollViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeScroViewCellID];
            if (!cell) {
                cell.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
            
            break;
            
            
            case 1:
        {
            homeClassifiedAdsTableViewCell *classCell = [[homeClassifiedAdsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeClassfiedCellID];
            if (!classCell) {
                classCell.delegate = self;
                
            }
            classCell.selectionStyle = UITableViewCellSelectionStyleNone;
            classCell.backgroundColor = [UIColor whiteColor];
            return classCell;
        }
            break;
            
            case 2:
        {
            throughOurTableViewCell *throuchCell = [[throughOurTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:throughOurCell];
            if (!throughOurCell) {
                          }
            throuchCell.selectionStyle = UITableViewCellSelectionStyleNone;
            throuchCell.backgroundColor = [UIColor whiteColor];
            return throuchCell;
        }
            break;
            
        default:
            break;
    }
    
    
    
    return nil;
    
}

//cell 的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return ScreenHeight/4;
    }
    if (indexPath.section == 1) {
        return ScreenWidth/4;
    }
    return 0;
    
}






//cell 选中时 实现方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
//    if (indexPath.section == 1) {
//        
//        
//        DetailData_ViewController *detailData = [[DetailData_ViewController alloc]init];
//        
//        //_____________________________________________________________________
//        backgroudModel *Model = allList[indexPath.row];
//        //    点击 cell 的时候 下载相应的图片 然后传值
//        NSArray *imageList = [imageDic objectForKey:@(indexPath.row)];
//        
//        if (Model.commodityImages.count!=0) {
//            
//            if (!imageList) {
//                DownloadOperation *loader = [[DownloadOperation alloc]initWithLoadImageURLString:Model.commodityImages andImageIndexPath:indexPath];
//                
//                loader.blocks = ^(NSArray *image,NSIndexPath *indexPath){
//                    if (image) {
//                        [imageDic setObject:image forKey:@(indexPath.row)];
//                        [tableView performSelectorOnMainThread:@selector(reloadRowsAtIndexPaths:withRowAnimation:) withObject:@[indexPath] waitUntilDone:YES];
//                    }
//                };
//                
//                [queue addOperation:loader];
//            }
//        }
//        
//        
//        
//        detailData.images = imageList ;
//        
//        detailData.imagesAdress = Model.commodityImages[1];
//        detailData.name = Model.commodityName;
//        detailData.price = Model.commodityPrice;
//        detailData.address = Model.address;
//        detailData.moreIntroduce = Model.moreIntroduce;
//        detailData.phone = Model.phone;
//        detailData.grade = Model.grade;
//        detailData.costPrice = Model.commodityCostPrice;
//        detailData.Introduce  = Model.commodityIntroduce;
//        
//        [self.navigationController pushViewController:detailData animated:NO];
//        
//    }
    
    
    
}



//表头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
    
}



#pragma mark 点击搜索栏按钮方法
- (void)ActiondoSearch_check:(UIButton *)button{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
