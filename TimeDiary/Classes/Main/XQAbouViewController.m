//
//  XQAbouViewController.m
//  TimeDiary
//
//  Created by iOSDevXiangQi on 2019/8/11.
//  Copyright © 2019年 iOSDevXiangQi. All rights reserved.
//

#import "XQAbouViewController.h"
#import "Masonry.h"

@interface XQAbouViewController ()
@property (nonatomic , strong) UITextView *tv;
@end

@implementation XQAbouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tv.text = @"贴心日记:\n一款能随时随地写日记、记录生活琐事、查看日历节假日的APP.\n功能特点:\n1、写日记：使用方便，可以添加文字、图片，可以给图片添加标签，也可以给编写的日记添加时间标记，便于查看。\n2、日历：提供阳历、农历、世界节假日、中国传统节气等，界面美观、使用方便。";
}

- (UITextView *)tv {
    if (!_tv) {
        _tv= [[UITextView alloc] init];
        _tv.editable = NO;
        _tv.alwaysBounceVertical = YES;
        _tv.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _tv.textColor = kColorFromHex(0x333333);
        _tv.font = kPingFangFont(16);
    }
    return _tv;
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
