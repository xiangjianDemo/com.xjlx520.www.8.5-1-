//
//  HomeTableViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/7.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "HomeTableViewController.h"
#import "TheAFNetWorking.h"
#import "SDCycleScrollView.h"
#import "homeScrollViewTableViewCell.h"
#import "homeClassifiedAdsTableViewCell.h"
#import "throughOurTableViewCell.h"
#import "homeClassCollectionViewCell.h"
#import "DrawLineView.h"
#import "DrawLineTowView.h"
#import "DrowLineThreeView.h"
#import "CFLineChartView.h"
#import "PushTableViewCell.h"
#import "RollingAdvertisingTableViewController.h"
#import "PushAdvertisingTableViewController.h"
#import "UIImageView+WebCache.h" // sdwebimage
#import "ClassAdsViewController.h"
#import "MBProgressHUD.h"
#import "ZhiViewController.h"
#import "MusicViewController.h"
#import "homeCollectionViewCell.h"
@interface HomeTableViewController ()<SDCycleScrollViewDelegate,homeScrollViewTableViewCellDelegate,homeClassifiedAdsTableViewCellDelegate,throughOurTableViewCellDelegate,SDWebImageManagerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>{

    SDCycleScrollView *cycleScrollView1;
    NSArray *imageArray;
    
    NSArray *classAdsArr;
    NSArray *rollAdsArr;
    NSMutableArray *imagesURLDtring;
}

@property (nonatomic, strong) CFLineChartView *LCView;
//@property (nonatomic, strong) Net *KYNet;

@end
static NSString *const collectionCellID = @"homeCollectionViewCell";
@implementation HomeTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"享见";
//    设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:104.0/255.0 blue:53.0/255.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = YES;
    
//   设置tabBar颜色
    [self.tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:10.0/255.0 green:104.0/255.0 blue:53.0/255.0 alpha:1.0]];
    
  
//    加此句去掉横线
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
//    得到单例
//    _KYNet = [Net getInstance];
//    挂上代理
//    _KYNet.delegate = self;
   
//    [self postClassAdsdata];
    [self postRollAdsData];
//    [self postAdsPage];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults valueForKey:@"nice"];
    
    NSLog(@"//////%@",name);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
//    开启线程，请求数据
    [NSThread detachNewThreadSelector:@selector(postClassAdsdata) toTarget:self withObject:nil];
}
// 请求头版广告方法
- (void)postRollAdsData{
    NSString *url = [TheAFNetWorking httpURLStr:@"admin/webapi/Handler_tb_advertisement.ashx?flag=advertisement_query"];
    [TheAFNetWorking postHttpsURL:url  parameters:nil AndSuccess:^(NSArray *dic) {
        rollAdsArr = dic;
        [self.tableView reloadData];

       
//        [self.delegate getWeatherInfoSuccessRoll:dic];
    } orfailure:^{
        NSLog(@"请求错误");
//        [self.delegate getWeatherInfoFailRoll:nil];
        
    } showHUD:YES];

}

//  请求分类广告方法
- (void)postClassAdsdata{
    NSString *url =[TheAFNetWorking httpURLStr:@"/admin/webapi/Handler_advertisement_fenl.ashx?flag=advertisement_fenl_query"];
    [TheAFNetWorking postHttpsURL:url parameters:nil AndSuccess:^(NSArray *dic) {
        
        classAdsArr = dic;
        //    现获取数据 再执行tableView
        [self.tableView reloadData];

        NSLog(@"%@",dic);
        
        
//        [self.delegate getWeatherInfoSuccessFeedback:dic];
    } orfailure:^{
//        [self.delegate getWeatherInfoFailFeedback:nil];
    } showHUD:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//homeScrollViewTableViewCell 代理方法
- (void)didTouchButton:(UIButton *)button andTableViewCell:(homeScrollViewTableViewCell *)cell{
    
}

//homeClassifiedAdsTableViewCell 代理方法
- (void)didTouchButton:(UIButton *)button addTableViewCell:(homeClassifiedAdsTableViewCell *)cell{
    
}

//throughOurTableViewCell 代理方法
- (void)didTouchbutton:(UIButton *)button addTableViewCell:(throughOurTableViewCell *)cell{
    
}


//SDCycleScrollView 代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
   NSLog(@"hello word");
//        RollingAdvertisingTableViewController *rolling = [[RollingAdvertisingTableViewController alloc]init];
//        [self.navigationController pushViewController:rolling animated:YES];
//    ClassifiedAdsTableViewController *class = [[ClassifiedAdsTableViewController alloc]init];
//    [self.navigationController pushViewController:class animated:YES];

    
}

//  实现 homeScrollViewTableViewCell 代理方法
- (void)didTouchSDCycle:(SDCycleScrollView *)SDCycle andTableViewCell:(homeScrollViewTableViewCell *)cell{
    if (SDCycle) {
        RollingAdvertisingTableViewController *rolling = [[RollingAdvertisingTableViewController alloc]init];
        [self.navigationController pushViewController:rolling animated:YES];
        NSLog(@"^=^点击图片");
        
    }
}


#pragma mark - Table view data source
// 返回section的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
    
}
// 返回每组section中cell的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }if (section == 1) {
        return 1;
    }if (section == 2) {
        return 1;
    }if (section == 3) {
        return 1;
    }
    return 1;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [UIScreen mainScreen].bounds.size.height/4;
    }if (indexPath.section == 1) {
        return 2*kScreenWidth/5+kScreenWidth/37.7*4;
    }if (indexPath.section == 2) {
        return [UIScreen mainScreen].bounds.size.height/10;
    }
        return ([UIScreen mainScreen].bounds.size.height/4)-20;
}
// cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *homeClassfiedCellID = @"homeClassfiedCellID";
    NSString *throughOurCell = @"throughOurCell";
    NSString *cellID;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    switch (indexPath.section) {
        case 0:
        {
            UIView *scroView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
            scroView.backgroundColor = [UIColor clearColor];
            [cell addSubview:scroView];
            
           
            //        第三方滚动视图  本地加载图片
            imageArray = @[[UIImage imageNamed:@"image0"],[UIImage imageNamed:@"image1"],[UIImage imageNamed:@"image2"],[UIImage imageNamed:@"image3"],[UIImage imageNamed:@"image3"]];
            cycleScrollView1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/4) imagesGroup:imageArray];
           
//             网络加载图片
            
            NSString *httpUrl = @"http://219.151.12.30:8081";
           
            imagesURLDtring = [@[]mutableCopy];// 复制对象
            for (int i = 0; i < rollAdsArr.count; i++) {
                NSString *url = [[NSString alloc]initWithFormat:@"%@%@",httpUrl,rollAdsArr[i][@"lx_picture"]];
                [imagesURLDtring addObject:url];
//                NSLog(@"图片地址：%@",imagesURLDtring);
            }
            
            cycleScrollView1.imageURLStringsGroup = imagesURLDtring;
            
            
            cycleScrollView1.delegate = self;
            cycleScrollView1.dotColor = [UIColor greenColor];//分页控制小图标颜色
            cycleScrollView1.pageControlDotSize = CGSizeMake(5, 5);//分页控件小图标大小
            cycleScrollView1.placeholderImage = [UIImage imageNamed:@"image3"];//占位图，用于网络未加载到图片时
            [scroView addSubview:cycleScrollView1];
            return cell;
            
        }
            
            break;
            
            
        case 1:
        {
            
             UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            
            UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
            
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            UIEdgeInsets top = {kScreenWidth/2/4/3.4,kScteenHeight/66.7*2.5,kScreenWidth/37.7,kScteenHeight/66.7*3};
            flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.width/3);
            
            [flowLayout setSectionInset:top];
            
            //                    单元格
            UICollectionView * collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2*kScreenWidth/5+kScreenWidth/37.7*4)collectionViewLayout:flowLayout];
            
            collectionView.backgroundColor=[UIColor clearColor];
            
            //注册单元格
         //   [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:identifier];
            [collectionView registerNib:[UINib nibWithNibName:collectionCellID bundle:nil] forCellWithReuseIdentifier:collectionCellID];
            //设置代理
            
            collectionView.delegate = self;
            
            collectionView.dataSource = self;
//            画线
            DrawLineView *line = [[DrawLineView alloc]init];
            line.backgroundColor = [UIColor clearColor];
            line.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/4 + kScreenWidth/37.7*2);
            
            
            //    折线1
            UIBezierPath *linePath1 = [UIBezierPath bezierPath];
            [linePath1 moveToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5/2, 50)];// 起点
            
                [linePath1 addLineToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5/2+10, 25+50+25+([UIScreen mainScreen].bounds.size.height/4-130)/2)];// 添加点数
            [linePath1 addLineToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5/2+20, 50)];
            [linePath1 addLineToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5/2+30, 25+50+25+([UIScreen mainScreen].bounds.size.height/4-130)/2)];
            
            CAShapeLayer *layer = [[CAShapeLayer alloc]init];
            layer.path = linePath1.CGPath;
            layer.strokeColor = [UIColor colorWithRed:88.0/255.0 green:163.0/255.0 blue:130.0/255.0 alpha:1.0].CGColor;
            layer.fillColor = [UIColor clearColor].CGColor;
            
            
            //   折线2
            UIBezierPath *linePath2 = [UIBezierPath bezierPath];
            [linePath2 moveToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5/2, 25+50+25+([UIScreen mainScreen].bounds.size.height/4-130)/2)];
            
                [linePath2 addLineToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5/2+10, 25+25)];
            [linePath2 addLineToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5/2+20, 25+50+25+([UIScreen mainScreen].bounds.size.height/4-130)/2)];
            [linePath2 addLineToPoint:CGPointMake(25+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5+[UIScreen mainScreen].bounds.size.width/5/2+30, 25+25)];
            
            CAShapeLayer *layer2 = [[CAShapeLayer alloc]init];
            layer2.path = linePath2.CGPath;
            layer2.strokeColor = [UIColor colorWithRed:252.0/255.0 green:207.0/255.0 blue:124.0/255.0 alpha:1.0].CGColor;
            layer2.fillColor = [UIColor clearColor].CGColor;
            
            
            
            [cell.contentView addSubview:collectionView];//添加collection
            [cell.contentView addSubview:line];//添加画线
            [cell.contentView.layer addSublayer:layer];// 添加折线1
            [cell.contentView.layer addSublayer:layer2]; // 添加折线2
            [cell.contentView addSubview:collectionView];//添加collection
            return cell;
        }
            break;
        case 2:
        {
            PushTableViewCell *cell = [[PushTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeClassfiedCellID];
//            if (!cell) {
//                cell.delegate = self;
//            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            //            画线
            DrowLineThreeView *line = [[DrowLineThreeView alloc]init];
            line.backgroundColor = [UIColor clearColor];
            line.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/10);
            [cell.contentView addSubview:line];
            
           return cell;
        }
            break;
        case 3:
        {
            throughOurTableViewCell *throuchCell = [[throughOurTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:throughOurCell];
            throuchCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [throuchCell.button1 setImage:[UIImage imageNamed:@"class"] forState: UIControlStateNormal];
            [throuchCell.button1 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
            
            [throuchCell.button2 setImage:[UIImage imageNamed:@"XJian"] forState:UIControlStateNormal];
            [throuchCell.button2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
            throuchCell.label1.text = @"分类直播";
            throuchCell.label2.text = @"享见乐播";
            throuchCell.backgroundColor = [UIColor whiteColor];
            return throuchCell;
        }
            break;
        case 4:
        {
            throughOurTableViewCell *throuchCell = [[throughOurTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:throughOurCell];
            throuchCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [throuchCell.button1 setImage:[UIImage imageNamed:@"LuckDraw"] forState: UIControlStateNormal];
            [throuchCell.button2 setImage:[UIImage imageNamed:@"Life"] forState:UIControlStateNormal];
            throuchCell.label1.text = @"抽奖";
            throuchCell.label2.text = @"活动";
            throuchCell.backgroundColor = [UIColor whiteColor];
            return throuchCell;
            
        }
            break;
            
        default:
            break;
    }
    
    // Configure the cell...
    
    return nil;
}

// 点击tableviewcell实现跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        PushAdvertisingTableViewController *pushView = [[PushAdvertisingTableViewController alloc]init];
        [self.navigationController pushViewController:pushView animated:YES];
    }
    
}

//点击直播跳转
- (void)buttonAction1:(UIButton *)button1{
    
    ZhiViewController *zhiview = [[ZhiViewController alloc]init];
    [zhiview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zhiview animated:YES];
    NSLog(@"分类直播被电击");
}
- (void)buttonAction2:(UIButton *)button2{
    
    MusicViewController *Musicview = [[MusicViewController alloc]init];
    [Musicview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:Musicview animated:YES];
    NSLog(@"享乐直播被电击");
}

#pragma mark ＝＝＝collextionview的delegate

// 每组cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return classAdsArr.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


// 设置cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     homeCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    cell1.backgroundColor = [UIColor clearColor];
    NSString *httpUrl = @"http://219.151.12.30:8081";
    NSString *url = [[NSString alloc]initWithFormat:@"%@%@",httpUrl,classAdsArr[indexPath.row][@"lx_picture"]];
    [cell1.img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"wo.png"]];
    
    cell1.label1.text = [classAdsArr[indexPath.row]objectForKey:@"lx_name"];
    
    
    
    
    return cell1;
   }

//设置元素大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    return CGSizeMake(kScreenWidth/5,kScreenWidth/5);
    
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    ClassAdsViewController *class = [[ClassAdsViewController alloc]init];
//    点击collection事 将lx_id传到页面  
    class.lx_id = [classAdsArr[indexPath.row]objectForKey:@"lx_id"];
//    输出id
//    NSLog(@"ID:%@",[classAdsArr[indexPath.row]objectForKey:@"lx_id"]);

    
    [self.navigationController pushViewController:class animated:YES];
    
//    NSLog(@"hello word");
}
// 定义每个uicollctionview的间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 10, 5, 5);
//}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    }
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
