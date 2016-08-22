//
//  CreateLiveViewController.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/22.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "CreateLiveViewController.h"
#import "MXPhotoView.h"

@interface CreateLiveViewController ()<MXPhotoViewUpdateDelegate>

@end

@implementation CreateLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建直播房间";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createrView];
}

- (void)createrView{
    
    UILabel *label1  = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/33.7*2, kScreenWidth/3.37, kScreenWidth/3, kScteenHeight/25)];
    label1.backgroundColor = [UIColor orangeColor];
    label1.text = @"请选择直播图片:";
    [self.view addSubview:label1];
    
    MXPhotoView *photoView = [[MXPhotoView alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, kScreenWidth/3.77, 100, 100)];
    photoView.photoViewDele = self;
    photoView.delegate = self;
    photoView.isNeedMovie = YES;
    photoView.showNum = 4;
    [self.view addSubview:photoView];
    
}

#pragma mark ==== MXPhotoViewDelegate =====
- (void)upLoadImageWithData:(NSData *)data{
    
}
- (void)upLoadVideoWithData:(NSData *)data{
    
}
- (void)getImagePathList:(NSArray *)imageList{
    
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
