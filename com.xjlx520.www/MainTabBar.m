//
//  MainTabBar.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/14.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"
@interface MainTabBar ()
@property(nonatomic, strong)NSMutableArray *tabBarBtnArray;
@property(nonatomic,weak)UIButton *writeButton;
@property(nonatomic,weak)MainTabBarButton *selectedButton;
@end

@implementation MainTabBar

- (NSMutableArray *)tabBarBtnArray{
    if (!_tabBarBtnArray) {
        _tabBarBtnArray = [NSMutableArray array];
    }
    return _tabBarBtnArray;
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupWriteButton];
    }
    return self;
}
- (void)setupWriteButton{
    UIButton *writeButton = [UIButton new];
    writeButton.adjustsImageWhenHighlighted = NO;
    [writeButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [writeButton addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    writeButton.bounds = CGRectMake(0, 0, writeButton.currentBackgroundImage.size.width, writeButton.currentBackgroundImage.size.height);
    [self addSubview:writeButton];
    _writeButton = writeButton;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.writeButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabBarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        MainTabBarButton *tabBarBtn = self.tabBarBtnArray[nIndex];
        if (nIndex > 1) {
            btnX += btnW;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
}
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabBarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabBarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}

- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}

- (void)ClickWriteButton{
    if ([self.delegate respondsToSelector:@selector(tabBarClickWriteButton:)]) {
        [self.delegate tabBarClickWriteButton:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
