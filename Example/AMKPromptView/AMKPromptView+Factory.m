//
//  AMKPromptView+Factory.m
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/3.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import "AMKPromptView+Factory.h"
#import "AMKPlaceholderView+Factory.h"

@implementation AMKPromptView (Factory)

#pragma mark - Init Methods

+ (instancetype)promptViewForDemo {
    AMKPromptView *promptView = [AMKPromptView new];
    promptView.restrictedView = [AMKPlaceholderView restrictedView];
    promptView.loadingView = [AMKPlaceholderView loadingViewWithGif];
    promptView.errorView = [AMKPlaceholderView errorView];
    promptView.emptyView = [AMKPlaceholderView emptyViewForNoColorsLoaded];
    
    // 清除之前绑定的事件
    [promptView.restrictedView.button removeAllTargets];
    [promptView.restrictedView.tapGestureRecognizer removeAllActionBlocks];
    [promptView.loadingView.button removeAllTargets];
    [promptView.loadingView.tapGestureRecognizer removeAllActionBlocks];
    [promptView.errorView.button removeAllTargets];
    [promptView.errorView.tapGestureRecognizer removeAllActionBlocks];
    [promptView.emptyView.button removeAllTargets];
    [promptView.emptyView.tapGestureRecognizer removeAllActionBlocks];
    
    // 绑定新的事件
    __weak AMKPromptView *weakPromptView = promptView;
    [promptView.restrictedView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.restrictedView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.loadingView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.loadingView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.errorView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.errorView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.emptyView.button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.emptyView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    return promptView;
}

+ (instancetype)promptViewFor500PX {
    AMKPromptView *promptView = [AMKPromptView new];
    promptView.loadingView = [AMKPlaceholderView loadingViewWithGif];
    promptView.emptyView = [AMKPlaceholderView emptyViewForNoColorsLoaded];

    // 清除之前绑定的事件
    [promptView.loadingView.button removeAllTargets];
    [promptView.loadingView.tapGestureRecognizer removeAllActionBlocks];
    [promptView.emptyView.button removeAllTargets];
    [promptView.emptyView.tapGestureRecognizer removeAllActionBlocks];

    // 绑定新的事件
    __weak AMKPromptView *weakPromptView = promptView;
    [promptView.loadingView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.loadingView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.emptyView.button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    [promptView.emptyView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPromptView setStatus:weakPromptView.nextStatus animated:YES completion:nil];
    }];
    return promptView;
}

#pragma mark - Properties

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
