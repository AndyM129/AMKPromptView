//
//  AMKViewController.m
//  AMKPromptView
//
//  Created by AndyM129 on 07/03/2019.
//  Copyright (c) 2019 https://github.com/AndyM129 . All rights reserved.
//

#import "AMKViewController.h"
#import "AMKPlaceholderView+Factory.h"

typedef NS_ENUM(NSInteger, AMKPromptType) {
    AMKPromptTypeEmptyViewForNoColorsLoaded = 0,        //!< 显示占位视图到 self.view 上
    AMKPromptTypeEmptyViewForNoColorsLoadedInWindow,    //!< 显示占位视图到 Window 上
    AMKPromptTypeLoadingViewWithActivityIndicator,      //!<
    AMKPromptTypeLoadingViewWithGif,                    //!<
    AMKPromptTypeCount, //!< 计数
};

@interface AMKViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong, nullable) UITableView *tableView;
@end

@implementation AMKViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AMKPromptView Demo";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Properties

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return AMKPromptTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    switch (indexPath.row) {
        case AMKPromptTypeEmptyViewForNoColorsLoaded: cell.textLabel.text = @"显示“空数据”提示到 self.view 上"; break;
        case AMKPromptTypeEmptyViewForNoColorsLoadedInWindow: cell.textLabel.text = @"显示“空数据”提示到 Window 上"; break;
        case AMKPromptTypeLoadingViewWithActivityIndicator: cell.textLabel.text = @"显示“加载中”提示"; break;
        case AMKPromptTypeLoadingViewWithGif: cell.textLabel.text = @"显示“加载中”提示: Gif"; break;
        default: cell.textLabel.text = nil; break;
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case AMKPromptTypeEmptyViewForNoColorsLoaded: {
            [AMKPlaceholderView.emptyViewForNoColorsLoaded show:YES inView:self.view animated:YES];
            break;
        }
        case AMKPromptTypeEmptyViewForNoColorsLoadedInWindow: {
            [AMKPlaceholderView.emptyViewForNoColorsLoaded show:YES inView:nil animated:YES];
            break;
        }
        case AMKPromptTypeLoadingViewWithActivityIndicator: {
            [AMKPlaceholderView.loadingViewWithActivityIndicator show:YES inView:nil animated:YES];
            break;
        }
        case AMKPromptTypeLoadingViewWithGif: {
            [AMKPlaceholderView.loadingViewWithGif show:YES inView:nil animated:YES];
            break;
        }
        default: break;
    }
}

#pragma mark - Override

#pragma mark - Helper Methods

@end
