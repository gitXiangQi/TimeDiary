//
//  XQBaseTabBarController.m
//  OutdoorTools_XQ
//
//  Created by iOSDevXiangQi on 2019/7/24.
//  Copyright © 2019年 iOSDevXiangQi. All rights reserved.
//

#import "XQBaseTabBarController.h"
#import "JBNavigationVController.h"
#import "XQTimeDairyViewController.h"
#import "XQCalendarViewController.h"
#import "XQSettingViewController.h"

@interface XQBaseTabBarController ()

@end

@implementation XQBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [CYTabBarConfig shared].selectedTextColor = kColorFromHex(0xf4ea2a);
        [CYTabBarConfig shared].textColor = kColorFromHex(0xffffff);
        [CYTabBarConfig shared].HidesBottomBarWhenPushedOption = HidesBottomBarWhenPushedAlone;
        [CYTabBarConfig shared].selectIndex = 0;
//        [CYTabBarConfig shared].centerBtnIndex = 1;
//        [CYTabBarConfig shared].bulgeHeight = 8.0f;
        [CYTabBarConfig shared].backgroundColor = kColorFromHex(0xEF716C);
        self.tabBar.translucent = NO;
        [self addChildViewControllers];
        
    }
    return self;
}


- (void)addChildViewControllers {
    [self addChildController:[[JBNavigationVController alloc] initWithRootViewController:[XQTimeDairyViewController new]] title:@"贴心日记" imageName:@"note" selectedImageName:@"note_select"];
    [self addChildController:[XQCalendarViewController new] title:@"时光日历" imageName:@"calender" selectedImageName:@"calender_select"];
    [self addChildController:[[JBNavigationVController alloc] initWithRootViewController:[XQSettingViewController new]] title:@"关于" imageName:@"about" selectedImageName:@"about_select"];
    
//    [self addCenterController:[XQCompassViewController new] bulge:YES title:@"指南针" imageName:@"compass_center" selectedImageName:@"compass_center"];
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
