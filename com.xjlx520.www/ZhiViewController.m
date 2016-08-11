//
//  ZhiViewController.m
//  com.xjlx520.www
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "ZhiViewController.h"

@interface ZhiViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    CGFloat _screenWidth;
}

@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIScrollView *bigScrollView;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"分类直播";
    [self createBigScrollView];
    [self createScrollView];
    [self addButton];
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 大的横向视图：
//大的横向ScrollView；
- (void)createBigScrollView{
    
    _bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-44)];
    _bigScrollView.backgroundColor = [UIColor blackColor];
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

//创建第一页的竖向滚动视图:
- (void)createCollectionView {
    CGRect frame = CGRectMake(0,0, self.view.frame.size.width,CGRectGetHeight(_bigScrollView.frame)-64-44);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[self createLayout]];
    _collectionView.bounces = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionView class] forCellWithReuseIdentifier:@"cellId"];
    [_bigScrollView addSubview:_collectionView];
    
}

- (UICollectionViewLayout *)createLayout
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
