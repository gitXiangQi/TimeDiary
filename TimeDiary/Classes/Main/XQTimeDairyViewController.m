//
//  XQTimeDairyViewController.m
//  TimeDiary
//
//  Created by iOSDevXiangQi on 2019/8/10.
//  Copyright © 2019年 iOSDevXiangQi. All rights reserved.
//

#import "XQTimeDairyViewController.h"
#import "JBMemoViewController.h"
#import "JBMemoDAL.h"
#import "JBMemo.h"
#import "JBHeaderView.h"
#import "JBMemoViewCell.h"
#import "UIScrollView+EmptyDataSet.h"

@interface XQTimeDairyViewController ()<JBHeaderViewDelegate,JBMemoViewCellDelegate , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) NSArray *memos;
///显示分组传值
@property (strong, nonatomic) UILabel *showLabel;

@end

@implementation XQTimeDairyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"贴心日记";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kGetImage(@"writegood") style:UIBarButtonItemStyleDone target:self action:@selector(newMemo)];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"JBMemoViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.memos = [[JBMemoDAL sharedInstance] selectAllMemos];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageViewDidSelectItem:) name:@"imageViewDidSelectItemNotif" object:nil];
}

- (void)newMemo {
    JBMemoViewController *memoVC = [[JBMemoViewController alloc] init];
    memoVC.members = @[@"@XQ"];
    __weak typeof(self) weakSelf = self;
    memoVC.saveBlock = ^{
        weakSelf.memos = [[JBMemoDAL sharedInstance] selectAllMemos];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:memoVC animated:YES];
}
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.memos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBMemo *memo = self.memos[indexPath.section];
    JBMemoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.memo = memo;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JBMemo *memo=self.memos[section];
    JBHeaderView *headerView=[JBHeaderView headerViewWithTableView:tableView];
    headerView.memo=memo;
    headerView.tag = section;
    headerView.delegate = self;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBMemo *memo = self.memos[indexPath.section];
    CGFloat height = [memo.textContent heightWithFontSize:14 Width:JBScreenWidth-129];
    //    if (!memo.isVisible) {
    //        height = 17;
    //    }
    //    if (memo.imageNames.length > 10 || memo.isShowRecord) {
    //        height += 70;
    //    }
    if (height > 17) {
        memo.isShowExpandedView = YES;
    }else{
        memo.isShowExpandedView = NO;
    }
    if (!memo.isVisible) {
        height = 17;
    }
    if (memo.picNum || memo.voiceNum) {
        height += 70;
    }
    return height+31;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= self.memos.count) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    JBMemo *memo = self.memos[indexPath.section];
    JBMemoViewController *memoVC = [[JBMemoViewController alloc] init];
    memoVC.members = @[@"@XQ"];
    memoVC.memo = memo;
    __weak typeof(self) weakSelf = self;
    memoVC.saveBlock = ^{
        weakSelf.memos = [[JBMemoDAL sharedInstance] selectAllMemos];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:memoVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBMemo *memo = self.memos[indexPath.section];
    [[JBMemoDAL sharedInstance] deleteMemoWithMemo_id:memo.memo_id];
    self.memos = [[JBMemoDAL sharedInstance] selectAllMemos];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    // 删除沙盒文件
    NSArray *imageNames = [memo.imageNames componentsSeparatedByString:@","];
    for (NSString *imageName in imageNames) {
        NSString *item,*filePath = nil;
        if (imageName.length == 36) {
            item = [imageName substringToIndex:18];
        }
        NSString *documentPath = [NSUserDefaults getDocumentPath];
        if (item) {
            filePath = [documentPath stringByAppendingPathComponent:item];
        }else{
            filePath = [documentPath stringByAppendingPathComponent:imageName];
        }
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}
#pragma mark - JBMemoViewCellDelegate
- (void)memoViewCellShowOrHide:(JBMemoViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    JBMemo *memo = self.memos[indexPath.section];
    memo.visible = !memo.visible;
    [self.tableView reloadData];
}
#pragma mark - JBHeaderViewDelegate
- (void)headerViewDidClickIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return kGetImage(@"empty_placeholder");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"空空如也～";
    NSDictionary *attributes = @{NSFontAttributeName: kPingFangFont(15),
                                 NSForegroundColorAttributeName: kColorFromHex(0x999999),
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"点击右上角添加日记吧~";
    NSDictionary *attributes = @{NSFontAttributeName: kPingFangFont(15),
                                 NSForegroundColorAttributeName: kColorFromHex(0x999999),
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - 处理通知
- (void)imageViewDidSelectItem:(NSNotification *)notify{
    NSDictionary *userInfo = notify.userInfo;
    NSIndexPath *indexPath = userInfo[@"indexPath"];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
