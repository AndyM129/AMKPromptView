//
//  UIViewController+AMKPromptView.m
//  AMKPromptView
//
//  Created by 孟昕欣 on 2019/7/4.
//

#import "UIViewController+AMKPromptView.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

@implementation UIViewController (AMKPromptView)

#pragma mark - Life Circle

#pragma mark - Properties

- (AMKPromptView *)amk_promptView {
    AMKPromptView *_promptView = objc_getAssociatedObject(self, @selector(amk_promptView));
    if (!_promptView) {
        _promptView = [[AMKPromptView alloc] init];
        _promptView.delegate = self;
        _promptView.restrictedView = [self amk_placeholderViewWithPromptStatus:AMKPromptStatusRestricted];
        _promptView.loadingView = [self amk_placeholderViewWithPromptStatus:AMKPromptStatusLoading];
        _promptView.errorView = [self amk_placeholderViewWithPromptStatus:AMKPromptStatusError];
        _promptView.emptyView = [self amk_placeholderViewWithPromptStatus:AMKPromptStatusEmpty];
        [self setAmk_promptView:_promptView];
        [self.view addSubview:_promptView];
        [_promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _promptView;
}

- (void)setAmk_promptView:(AMKPromptView *)amk_promptView {
    objc_setAssociatedObject(self, @selector(amk_promptView), amk_promptView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (AMKPlaceholderView *_Nullable)amk_placeholderViewWithPromptStatus:(AMKPromptStatus)status {
    AMKPlaceholderView *placeholderView = nil;
    switch (status) {
        case AMKPromptStatusRestricted: {
            // 底部按钮
            UIColor *normalBackgroundColor = [self.view tintColor];
            UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitle:@"去登陆" forState:UIControlStateNormal];
            [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
            
            // 占位视图
            placeholderView = [AMKPlaceholderView new];
            placeholderView.titleLabel.text = @"未登录";
            placeholderView.button = button;
            break;
        }
        case AMKPromptStatusLoading: {
            // 提示视图
            UIActivityIndicatorView *indicatorView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            // 占位视图
            placeholderView = [AMKPlaceholderView new];
            placeholderView.indicatorView = indicatorView;
            placeholderView.titleLabel.text = @"加载中...";
            break;
        }
        case AMKPromptStatusError: {
            // 底部按钮
            UIColor *normalBackgroundColor = [self.view tintColor];
            UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitle:@"刷新" forState:UIControlStateNormal];
            [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
            
            // 占位视图
            placeholderView = [AMKPlaceholderView new];
            placeholderView.titleLabel.text = @"啊哦，好像出了点小问题";
            placeholderView.button = button;
            break;
        }
        case AMKPromptStatusEmpty: {
            // 底部按钮
            UIColor *normalBackgroundColor = [self.view tintColor];
            UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitle:@"刷新" forState:UIControlStateNormal];
            [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
            
            // 占位视图
            placeholderView = [AMKPlaceholderView new];
            placeholderView.titleLabel.text = @"这里空空如也~~";
            placeholderView.button = button;
            break;
        }
        default: break;
    }    
    return placeholderView;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
