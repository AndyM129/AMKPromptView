//
//  AMKCustomViewController.m
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/4.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import "AMKCustomViewController.h"
#import <AMKPromptView/UIViewController+AMKPromptView.h>

@interface AMKCustomViewController ()
@property(nonatomic, assign) AMKPromptType promptType;
@end

@implementation AMKCustomViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (instancetype)initWithPromptType:(AMKPromptType)promptType {
    if (self = [self init]) {
        self.promptType = promptType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
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

- (AMKPlaceholderView *)amk_placeholderViewWithPromptStatus:(AMKPromptStatus)status {
    AMKPlaceholderView *placeholderView = nil;
    if (self.promptType == AMKPromptType500PX) {
        if (status == AMKPromptStatusLoading) return [AMKPlaceholderView loadingViewFor500PX];
        if (status == AMKPromptStatusEmpty) return [AMKPlaceholderView emptyViewFor500PX];
    }
    return placeholderView;
}

#pragma mark - Helper Methods

@end
