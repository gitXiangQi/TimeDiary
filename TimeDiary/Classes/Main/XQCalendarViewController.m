//
//  XQCalendarViewController.m
//  TimeDiary
//
//  Created by iOSDevXiangQi on 2019/8/10.
//  Copyright © 2019年 iOSDevXiangQi. All rights reserved.
//

#import "XQCalendarViewController.h"

#import "CalendarSignInHeaderView.h"
#import "Masonry.h"
#import "SoCalendarView.h"
#import "CalendarSignInFooterView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

// 判断是否是iPhone X系列
#define iPhoneX ([UIScreen mainScreen].bounds.size.height >= 812)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define iPhoneX_Top (iPhoneX ? 88.0f : 64.0f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define iPhoneX_Bottom (iPhoneX ? 34.0f : 0.0f)

@interface XQCalendarViewController ()

@property (nonatomic,strong) CalendarSignInHeaderView *headerView;
@property (nonatomic,strong) SoCalendarView *calendarView;
@property (nonatomic,strong) CalendarSignInFooterView *footerView;
@end

@implementation XQCalendarViewController

- (CalendarSignInHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[CalendarSignInHeaderView alloc] init];
        
    }
    
    return _headerView;
}

- (SoCalendarView *)calendarView{
    
    if (!_calendarView) {
        
        _calendarView = [[SoCalendarView alloc] initWithSoCalendarViewWithFrame:CGRectMake(0, 0, kScreenW - 28, (kScreenW - 28) * 0.86)];
    }
    
    return _calendarView;
}

- (CalendarSignInFooterView *)footerView{
    
    if (!_footerView) {
        __weak typeof(self) weakSelf = self;
        _footerView = [[CalendarSignInFooterView alloc] init];
        [_footerView setTapBlock:^{
            weakSelf.tabBarController.selectedIndex = 0;
        }];
    }
    
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.calendarView];
    
    [self.view addSubview:self.footerView];
    
    CGFloat headerScale = 0.4;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(iPhoneX_Top + headerScale * SCREEN_WIDTH);
    }];
    
    CGFloat calendarScale = 0.86;
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(14);
        make.right.equalTo(self.view).offset(-14);
        make.top.equalTo(self.headerView.mas_bottom).offset(-35);
        make.height.mas_equalTo(calendarScale * (SCREEN_WIDTH - (28)));
    }];
    
    CGFloat footerScale = 0.31;
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(14);
        make.right.equalTo(self.view).offset(-14);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(footerScale * (SCREEN_WIDTH - (28)) + iPhoneX_Bottom);
    }];
    
}

@end
