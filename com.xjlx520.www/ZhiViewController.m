//
//  ZhiViewController.m
//  com.xjlx520.www
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "ZhiViewController.h"
#import "NEEnterViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "TheAFNetWorking.h"
#import "YXPMBProgressView.h"
#import "TwoCollectionViewCell.h"
#import "FourCollectionViewCell.h"
#import "NEStartLiveStreamViewController.h"
#import "NEStartLiveStreamViewController.h"
#import "NELivePlayerViewController.h"

#import "ZhiBoModel.h"
@interface ZhiViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    CGFloat _screenWidth;
}

@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIScrollView *bigScrollView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionView *twocollectionView;
@property (nonatomic,strong) UICollectionView *fourcollectionView;

@property (nonatomic,strong) NSMutableArray *dataArray2;
@property (nonatomic,strong) ZhiBoModel *model;
@property (nonatomic,assign) NSInteger twopages;

@end

@implementation ZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //禁止ScrollView因状态栏所偏移。
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"分类直播";
    _dataArray2 = [NSMutableArray new];
    
    
    [self createBigScrollView];
    [self createScrollView];
    [self addButton];
    [self createCollectionView];
    [self twocreateCollectionView];
    [self threecreateCollectionView];
    [self fourcreateCollectionView];
    // Do any additional setup after loading the view.
}

#pragma mark --- 大的横向视图：
//大的横向ScrollView；
- (void)createBigScrollView{
    
    _bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-44)];
    _bigScrollView.backgroundColor = [UIColor whiteColor];
    //控制滚动视图是否反弹过去内容的边缘
    _bigScrollView.bounces = NO;
    _bigScrollView.delegate = self;
    _bigScrollView.contentSize = CGSizeMake(4*self.view.frame.size.width, self.view.frame.size.height-94);
    _bigScrollView.pagingEnabled = YES;
    //不显示水平滚动条：
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    //决定是否弹跳总是出现水平滚动时达到结束内容的看法。
    _bigScrollView.alwaysBounceHorizontal = NO;
    [self.view addSubview:_bigScrollView];
}
//小的标题ScrollView:
- (void)createScrollView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}
//这个函数会在scrollview停止滑动的时候执行:
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _bigScrollView) {
        NSInteger index = _bigScrollView.contentOffset.x/self.view.frame.size.width;
        UIButton *button = (UIButton *)[self.view viewWithTag:index+100];
        _button.selected = NO;
        _button.transform = CGAffineTransformMakeScale(1, 1);
        button.selected = YES;
        _button = button;
        _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
}
//在视图滚动时接到通知:
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _bigScrollView) {
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(scrollView.contentOffset.x/_bigScrollView.frame.size.width*_screenWidth, CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
        }];
    }
}

- (void)addButton{
    
    _nameArray = @[@"热门",@"关注",@"频道",@"同城"];

    _screenWidth = self.view.frame.size.width/4;
    for (int i = 0; i < _nameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_screenWidth*i, 0, _screenWidth, 35);
        [button setTitle:_nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [_scrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _button = button;
            _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
            _label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)-1, _screenWidth, 2)];
            _label.backgroundColor = [UIColor redColor];
            [_scrollView addSubview:_label];
        }
    }
    _scrollView.contentSize = CGSizeMake(_screenWidth*_nameArray.count, 40);
    _scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)buttonClick:(UIButton *)button {
    if (_button == button) {
        return;
    }
    button.selected = YES;
    _button.selected = NO;
    _button.transform = CGAffineTransformMakeScale(1, 1);
    _button = button;
    _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5 animations:^{
        _label.frame = CGRectMake(CGRectGetMinX(_button.frame), CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _bigScrollView.contentOffset = CGPointMake(self.view.frame.size.width*(button.tag-100), 0);
    }];
}

#pragma mark --第二页请求数据
-(void)requestData:(void(^)())succeed{
    NSString *pagss1 = [NSString stringWithFormat:@"%ld",_twopages];
    
    NSString *url =[TheAFNetWorking httpURLStr:@"admin/webapi/lx_channel.ashx?flag=lxchanneqye"];
    
    NSDictionary *dicc = [[NSDictionary alloc]init];
    dicc = @{@"pags":pagss1,@"page":@"10"};
    NSLog(@"%ld",_twopages);
    
    [TheAFNetWorking postHttpsURL:url parameters:dicc AndSuccess:^(NSArray *dic) {
        
        for (NSDictionary *dic1 in dic) {
            _model = [[ZhiBoModel alloc]init];
            
            [_model yy_modelSetWithDictionary:dic1];
            [_dataArray2 addObject:_model];
           
        }
        if (dic!=nil) {
            if (succeed) {
                succeed();
            }
        }
        [_twocollectionView.mj_footer endRefreshing];
        [_twocollectionView.mj_header endRefreshing];

        //        [self.delegate getWeatherInfoSuccessFeedback:dic];
    } orfailure:^{//请求失败调用此方法
        [_twocollectionView.mj_footer endRefreshing];
        [_twocollectionView.mj_header endRefreshing];
        //        [self.delegate getWeatherInfoFailFeedback:nil];
    } showHUD:NO];
    

}

#pragma mark --创建第一页的竖向滚动视图
- (void)createCollectionView {
    CGRect frame = CGRectMake(0,0, self.view.frame.size.width/2-10,120);

    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:@"class"] forState: UIControlStateNormal];
    [button addTarget:self action:@selector(playButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:button];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+20, 0, self.view.frame.size.width/2-10, 120)];
    [button2 setImage:[UIImage imageNamed:@"XJian"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(playButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:button2];
    NSLog(@"1");
//    UIView *view1 = [[UIView alloc]initWithFrame:frame];
//
//    view1.backgroundColor = [UIColor greenColor];
//    [_bigScrollView addSubview: view1];
//    //直播点击手势：
//    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnPressed1:)];
//    
//    //一个手指点击触发：
//    tgr.numberOfTouchesRequired = 1;
//    //给UIImageView添加一个点击手势
//    view1.userInteractionEnabled = YES;
//    [view1 addGestureRecognizer:tgr];
//    
//    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame)+20, 0, self.view.frame.size.width/2-10, 120)];
//    view2.backgroundColor = [UIColor brownColor];
//    [_bigScrollView addSubview: view2];
}
//跳转直播页面
//- (void)btnPressed1:(UITapGestureRecognizer*)sender{
//    
//    NEEnterViewController *vc = [[NEEnterViewController alloc] init];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//}

//- (void)joinButtonPressed:(id)sender {
//    
//    NEStartLiveStreamViewController *startLive = [[NEStartLiveStreamViewController alloc] initWithNibName:nil bundle:nil];
//    startLive.pushUrl = @"rtmp://p68821d29.live.126.net/live/cbfa59943264487ab8e614165ce6c01c?wsSecret=ced02391f681db2b9ac1271fb564a6cf&wsTime=1470982510";
//    [self presentViewController:startLive animated:YES completion:nil];
//}

- (void)playButton:(UIButton *)button{
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://pullhls68821d29.live.126.net/live/12d0a54e818f4631afec028fa24f61b6/playlist.m3u8"];
    
    NSMutableArray *decodeParm = [[NSMutableArray alloc] init];
    [decodeParm addObject:@"software"];
    [decodeParm addObject:@"livestream"];
    
    NELivePlayerViewController *livePlayerVC = [[NELivePlayerViewController alloc] initWithURL:url andDecodeParm:decodeParm];
    livePlayerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:livePlayerVC animated:YES completion:nil];
    
}

#pragma mark --创建第二页的竖向滚动视图
- (void)twocreateCollectionView {
    CGRect frame = CGRectMake(self.view.frame.size.width,0, self.view.frame.size.width,CGRectGetHeight(_bigScrollView.frame)-64);
    _twocollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[self twocreateLayout]];
    _twocollectionView.bounces = YES;
    _twocollectionView.dataSource = self;
    _twocollectionView.delegate = self;
    
    _twocollectionView.backgroundColor = [UIColor whiteColor];
    [_twocollectionView registerClass:[TwoCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [_bigScrollView addSubview:_twocollectionView];
//    [self twopostClassAdsdata];
    
    MJRefreshNormalHeader *refreshHeader =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self twopostClassAdsdata:NO];
         _twopages = 1;
        [_dataArray2 removeAllObjects];
        [self requestData:^{
            [_twocollectionView reloadData];
        }];
    }];
    _twocollectionView.mj_header = refreshHeader;
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         _twopages++;
        [self requestData:^{
            [_twocollectionView reloadData];
        }];
//        [self twopostClassAdsdata:YES];
    }];
    _twocollectionView.mj_footer = refreshFooter;
    [refreshHeader beginRefreshing];
    NSLog(@"2");
}
/***********************第二页collectionView*******************************/
- (UICollectionViewLayout *)twocreateLayout
{
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //最小行间距：
    layout.minimumLineSpacing = 10;
    //item尺寸：
    layout.itemSize = CGSizeMake((CGRectGetWidth(self.view.frame)-30)/2,(CGRectGetWidth(self.view.frame)-30)*4/7);
    //四周边界：
    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    return layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (collectionView == _twocollectionView) {
        return _dataArray2.count;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _fourcollectionView) {
        FourCollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIId" forIndexPath:indexPath];
        //cell1.layer.shadowOffset =CGSizeMake(2, 2);
        cell2.layer.shadowRadius = 2;
        //cell1.layer.shadowOpacity = 0.5;
        cell2.backgroundColor = [UIColor whiteColor];
        cell2.userInteractionEnabled = YES;
//        [cell1 setModel:_dataArray2[indexPath.row] With:indexPath.row];
        return cell2;
    }
    TwoCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    //cell1.layer.shadowOffset =CGSizeMake(2, 2);
    cell1.layer.shadowRadius = 2;
    //cell1.layer.shadowOpacity = 0.5;
    cell1.backgroundColor = [UIColor whiteColor];
    cell1.userInteractionEnabled = YES;
    [cell1 setModel:_dataArray2[indexPath.row]];
    return cell1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    _model = _dataArray2[indexPath.row];
//    NSString *cid =[NSString stringWithFormat:@"http://pullhls68821d29.live.126.net/live/%@/playlist.m3u8",_model.cid];
    NSURL *url = [[NSURL alloc] initWithString:_model.hlsPullUrl];
    
    NSMutableArray *decodeParm = [[NSMutableArray alloc] init];
    [decodeParm addObject:@"software"];
    [decodeParm addObject:@"livestream"];
    
    NELivePlayerViewController *livePlayerVC = [[NELivePlayerViewController alloc] initWithURL:url andDecodeParm:decodeParm];
    livePlayerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:livePlayerVC animated:YES completion:nil];
}

#pragma mark --创建第三页的竖向滚动视图
- (void)threecreateCollectionView {
    CGRect frame = CGRectMake((self.view.frame.size.width)*2,0, self.view.frame.size.width/2-10,120);
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:@"class"] forState: UIControlStateNormal];
    //    [button addTarget:self action:@selector(joinButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:button];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+20, 0, self.view.frame.size.width/2-10, 120)];
    [button2 setImage:[UIImage imageNamed:@"XJian"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:button2];
    NSLog(@"3");
}

#pragma mark --创建第四页的竖向滚动视图
- (void)fourcreateCollectionView {
    CGRect frame = CGRectMake(self.view.frame.size.width*3,0, self.view.frame.size.width,CGRectGetHeight(_bigScrollView.frame)-64);
    _fourcollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[self fourcreateLayout]];
    _fourcollectionView.bounces = YES;
    _fourcollectionView.dataSource = self;
    _fourcollectionView.delegate = self;
    
    _fourcollectionView.backgroundColor = [UIColor whiteColor];
    [_fourcollectionView registerClass:[FourCollectionViewCell class] forCellWithReuseIdentifier:@"cellIId"];
    [_bigScrollView addSubview:_fourcollectionView];
    
    //    MJRefreshNormalHeader *refreshHeader =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [self twocreateCollectionView];
    //    }];
    //    _twocollectionView.mj_header = refreshHeader;
    //    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        [self twocreateCollectionView];
    //    }];
    //    _twocollectionView.mj_footer = refreshFooter;
    //    [refreshHeader beginRefreshing];

}
/***********************第四页collectionView*******************************/
- (UICollectionViewLayout *)fourcreateLayout
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //最小行间距：
    layout.minimumLineSpacing = 30;
    //item尺寸：
    layout.itemSize = CGSizeMake((CGRectGetWidth(self.view.frame)),(CGRectGetWidth(self.view.frame)));
    //四周边界：
    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
//    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    return layout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
