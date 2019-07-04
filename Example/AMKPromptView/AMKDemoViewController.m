//
//  AMKDemoViewController.m
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/4.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import "AMKDemoViewController.h"

@interface AMKDemoViewController ()

@end

@implementation AMKDemoViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIViewController+AMKPromptView";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.amk_promptView setStatus:AMKPromptStatusRestricted animated:YES completion:nil];
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark AMKPromptViewDelegate

/// 模拟：点击提示视图后的处理
- (void)promptView:(AMKPromptView *)promptView didClickPlaceholderView:(AMKPlaceholderView * _Nullable)placeholderView inStatus:(AMKPromptStatus)status {
    [self promptView:promptView didTapPlaceholderView:placeholderView inStatus:status];
}

/// 模拟：点击提示视图中按钮后的处理
- (void)promptView:(AMKPromptView *)promptView didTapPlaceholderView:(AMKPlaceholderView *)placeholderView inStatus:(AMKPromptStatus)status {
    // 假设当前是提示未登录，则点击后完成登录，开始加载数据
    if (status == AMKPromptStatusRestricted) {
        [promptView setStatus:AMKPromptStatusLoading animated:YES completion:nil];
    }
    // 假设当前是正在Loading，则点击后模拟 网络异常，或是 空数据
    else if (status == AMKPromptStatusLoading) {
        if (arc4random()%2==0) {
            [promptView setStatus:AMKPromptStatusError animated:YES completion:nil];
        } else {
            [promptView setStatus:AMKPromptStatusEmpty animated:YES completion:nil];
        }
    }
    // 假设当前是提示错误，则点击后重新请求数据
    else if (status == AMKPromptStatusError) {
        [promptView setStatus:AMKPromptStatusLoading animated:YES completion:nil];
    }
    // 假设当前是空数据，则点击后重新请求数据
    else if (status == AMKPromptStatusEmpty) {
        [promptView setStatus:AMKPromptStatusLoading animated:YES completion:nil];
    }
}

#pragma mark - Override

- (AMKPlaceholderView *)amk_placeholderViewWithPromptStatus:(AMKPromptStatus)status {
    AMKPlaceholderView *placeholderView = [super amk_placeholderViewWithPromptStatus:status];
    if (status == AMKPromptStatusError) {
        UIImage *indicatorImage = [UIImage imageNamed:@"amk_placeholder_error_network"];
        UIImageView *indicatorView = [[UIImageView alloc] initWithImage:indicatorImage];
        indicatorView.frame = CGRectMake(0, 0, indicatorImage.size.width, indicatorImage.size.height);
        placeholderView.indicatorView = indicatorView;
    }
    else if (status == AMKPromptStatusEmpty) {
        UIImage *indicatorImage = [UIImage imageNamed:@"amk_placeholder_empty_books"];
        UIImageView *indicatorView = [[UIImageView alloc] initWithImage:indicatorImage];
        indicatorView.frame = CGRectMake(0, 0, indicatorImage.size.width, indicatorImage.size.height);
        placeholderView.indicatorView = indicatorView;
    }
    return placeholderView;
}

#pragma mark - Helper Methods

@end

