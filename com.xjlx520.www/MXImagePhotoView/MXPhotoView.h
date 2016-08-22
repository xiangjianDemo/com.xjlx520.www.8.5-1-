//
//  MXPhotoView.h
//  MXImageSelectView
//
//  Created by maxin on 16/4/27.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXPhotoViewUpdateDelegate <NSObject>

- (void)upLoadImageWithData:(NSData *)data;

- (void)upLoadVideoWithData:(NSData *)data;

#pragma mark  ---- 添加代理方法，传回去 imageList
- (void)getImagePathList:(NSArray *)imageList;

@end

@interface MXPhotoView : UIView
//必传 传一个ViewController进去 一般传self
@property (nonatomic) id photoViewDele;
//是否可拍摄视频
@property (nonatomic) BOOL isNeedMovie;

//一行显示几个图片
@property (nonatomic) NSInteger showNum;
//图片宽 高
@property (nonatomic) CGFloat imageWidth;

@property (nonatomic) CGFloat imageHeight;


//update的代理
@property (nonatomic) id<MXPhotoViewUpdateDelegate>delegate;
@end
