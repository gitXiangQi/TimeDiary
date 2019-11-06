//
//  JBMemoViewController.h
//  备忘录
//
//  Created by ejb No.2 on 2016/10/19.
//  Copyright © 2016年 XQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBMemo;
@interface JBMemoViewController : BaseViewController
/// 权限成员
@property (nonatomic,strong) NSArray *members;
@property (nonatomic,strong) JBMemo *memo;
@property (nonatomic,copy) void(^saveBlock)();
@end

