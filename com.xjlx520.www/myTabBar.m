//
//  myTabBar.m
//  享见1.0
//
//  Created by 勇 舒 on 16/6/15.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "myTabBar.h"
#import "MainTabBarButton.h"

@interface myTabBar ()
@property(nonatomic,strong)NSMutableArray *tabBarBtnArray;
@property(nonatomic,weak)MainTabBarButton *selectedButton;

@end

@implementation myTabBar
- (NSMutableArray *)tabBarBtnArray{
    if (!_tabBarBtnArray) {
        _tabBarBtnArray = [NSMutableArray array];
    }
    return _tabBarBtnArray;
}
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor greenColor];
        
//        [self ClickWriteButton];
            }
    return self;
}


- (void)layoutSubviews{
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

- (void)addTaBabarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabBarBtnArray addObject:tabBarBtn];
    
    //    default selected first one
    if (self.tabBarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}
- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(taBbar:didSelectedButtonFrom:to:)]) {
//        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
        [self.delegate taBbar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}
- (void)ClickWriteButton{
    if ([self.delegate respondsToSelector:@selector(taBbarClickWriteButton:)]) {
//        [self.delegate tabBarClickWriteButton:self];
        [self.delegate taBbarClickWriteButton:self];
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
