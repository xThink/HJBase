//
//  HJViewController.m
//  HJBase
//
//  Created by HeJun on 07/16/2019.
//  Copyright (c) 2019 HeJun. All rights reserved.
//

#import "HJViewController.h"
#import "HJWebViewController.h"

@interface HJViewController ()

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation HJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    NSDictionary *dic = self.dataList[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HJWebViewController *vc = [HJWebViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazyload
- (NSArray *)dataList {
    return @[@{@"title": @"HJWebView"}];
}

@end
