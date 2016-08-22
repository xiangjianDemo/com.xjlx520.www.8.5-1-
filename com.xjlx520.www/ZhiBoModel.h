//
//  ZhiBoModel.h
//  com.xjlx520.www
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZhiBoModel : JSONModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pushUrl;
@property (nonatomic, copy) NSString *httpPullUrl;
@property (nonatomic, copy) NSString *hlsPullUrl;
@property (nonatomic, copy) NSString *rtmpPullUrl;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *tupian;

@end
