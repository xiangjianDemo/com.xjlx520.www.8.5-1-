//
//  homeClassifiedAdsTableViewCell.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/21.
//  Copyright © 2016年 勇 舒. All rights reserved.
//  ＊＊＊＊＊＊＊＊＊分类广告

#import "homeClassifiedAdsTableViewCell.h"
#import "homeClassCollectionViewCell.h"
//#import "SDRefresh.h"
//#import "UIImageView+WebCache.h"


@interface homeClassifiedAdsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *identifier;
}
@end

// 自定义宽、高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@implementation homeClassifiedAdsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
        
        self.colltionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        
//        设置代理
        self.colltionView.delegate = self;
        self.colltionView.dataSource = self;
//        添加colltionView
        [self addSubview:self.colltionView];
        
        self.colltionView.backgroundColor = [UIColor whiteColor];
//        注册cell和reusableView（相当于头部）
        [self.colltionView registerClass:[UICollectionView class] forCellWithReuseIdentifier:@"cell"];
        [self.colltionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        
        
        
        
        
        
        
        
        /*
        UIView *classifiedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/4)];
        classifiedView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:classifiedView];
        identifier = @"cell";
        
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //        UICollectionViewScrollDirectionVertical,
        //    UICollectionViewScrollDirectionHorizontal
        
        UIEdgeInsets top = {5,5,5,5};
        
        [flowLayout setSectionInset:top];
        
        //                    单元格
        UICollectionView * collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 140)collectionViewLayout:flowLayout];
        
        collectionView.backgroundColor=[UIColor whiteColor];
        //注册单元格
        
        [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:identifier];
        
        //设置代理
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [self.contentView addSubview:collectionView];*/
        
        
    }
    return self;
}

#pragma mark********UICollectionViewDataSource****

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
// 设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifer = [NSString stringWithFormat:@"cell%@",indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    [cell sizeToFit];
    cell.backgroundColor = [UIColor orangeColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"wo.png"];
    imageView.tag = indexPath.row;
    
    NSString *url = @"dsivbi";
    if (url) {
//    网络加载图片  
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 50, 25)];
    label.text = @"";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:12];
    [cell addSubview:imageView];
    [cell addSubview:label];
    
    return cell;
}

// 设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {10,2,15,2};
    return top;
}


// 设置单元格宽度

// 设置元素大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    long l=[[UIScreen mainScreen] bounds].size.width/4;
    return CGSizeMake(l,50);
    
}

// UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
}
// 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(void)acTion:(UIButton *)sender{
//    ********调用
    [self.delegate didTouchButton:sender addTableViewCell:self];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
