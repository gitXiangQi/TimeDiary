//
//  HeaderView.h
//
//
//  Created by ejb on 15/8/18.
//  Copyright (c) 2015年 XQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBHeaderView;
@protocol JBHeaderViewDelegate <NSObject>

- (void)headerViewDidClickIndexPath:(NSIndexPath *)indexPath;

@end

@class JBMemo;
@interface JBHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)  JBMemo *memo;
@property (nonatomic,weak) id<JBHeaderViewDelegate> delegate;

@end
