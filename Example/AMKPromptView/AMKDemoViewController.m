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
    self.title = @"";
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
    [promptView setStatus:promptView.nextStatus animated:YES completion:nil];
}

/// 模拟：点击提示视图中按钮后的处理
- (void)promptView:(AMKPromptView *)promptView didTapPlaceholderView:(AMKPlaceholderView *)placeholderView inStatus:(AMKPromptStatus)status {
    [promptView setStatus:promptView.nextStatus animated:YES completion:nil];
}

#pragma mark - Override

#pragma mark - Helper Methods

@end
