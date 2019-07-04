//
//  AMKPlaceholderView+Factory.m
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/3.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import "AMKPlaceholderView+Factory.h"

@implementation AMKPlaceholderView (Factory)

#pragma mark - Init Methods

+ (instancetype)restrictedView {
    // 底部按钮
    UIColor *normalBackgroundColor = [UIColor colorWithRed:4/255.0 green:125/255.0 blue:254/255.0 alpha:1/1.0];
    UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"Login" forState:UIControlStateNormal];
    [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    
    // 占位视图
    AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
    placeholderView.titleLabel.text = @"You have no right, please login.";
    placeholderView.button = button;
    
    // 绑定事件
    __weak AMKPlaceholderView *weakPlaceholderView = placeholderView;
    [placeholderView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    [placeholderView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    return placeholderView;
}

+ (instancetype)errorView {
    // 底部按钮
    UIColor *normalBackgroundColor = [UIColor colorWithRed:4/255.0 green:125/255.0 blue:254/255.0 alpha:1/1.0];
    UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"Reload" forState:UIControlStateNormal];
    [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    
    // 占位视图
    AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
    placeholderView.titleLabel.text = @"Sorry, there has something wrong.";
    placeholderView.button = button;
    
    // 绑定事件
    __weak AMKPlaceholderView *weakPlaceholderView = placeholderView;
    [placeholderView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    [placeholderView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    return placeholderView;
}

+ (instancetype)emptyViewForNoColorsLoaded {
    // 提示视图
    UIImage *indicatorImage = [UIImage imageNamed:@"amk_placeholder_empty_colors"];
    UIImageView *indicatorView = [[UIImageView alloc] initWithImage:indicatorImage];
    indicatorView.frame = CGRectMake(0, 0, indicatorImage.size.width, indicatorImage.size.height);
    
    // 底部按钮
    UIColor *normalBackgroundColor = [UIColor colorWithRed:4/255.0 green:125/255.0 blue:254/255.0 alpha:1/1.0];
    UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"Go Back" forState:UIControlStateNormal];
    [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    
    // 占位视图
    AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
    placeholderView.indicatorView = indicatorView;
    placeholderView.titleLabel.text = @"No colors loaded";
    placeholderView.subTitleLabel.text = @"To show a list of random colors, tap on the refresh icon in the right top corner.\n\nTo clean the list, tap on the trash icon.";
    placeholderView.button = button;
    
    // 绑定事件
    __weak AMKPlaceholderView *weakPlaceholderView = placeholderView;
    [placeholderView.button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"");
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    [placeholderView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        NSLog(@"");
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    return placeholderView;
}

+ (instancetype)loadingViewWithActivityIndicator {
    // 提示视图
    UIActivityIndicatorView *indicatorView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // 占位视图
    AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
    placeholderView.indicatorView = indicatorView;
    placeholderView.titleLabel.text = @"Loading ...";
    
    // 绑定事件
    __weak AMKPlaceholderView *weakPlaceholderView = placeholderView;
    [placeholderView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        NSLog(@"");
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    return placeholderView;
}

+ (instancetype)loadingViewWithGif {
    // 提示视图
    UIImageView *indicatorView = [[UIImageView alloc] init];
    indicatorView.animationImages = [UIImage amkpv_imagesWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"amk_placeholder_loading" ofType:@"gif"]];
    indicatorView.animationDuration = indicatorView.animationImages.count / 10.0;
    indicatorView.frame = CGRectMake(0, 0, indicatorView.animationImages.firstObject.size.width, indicatorView.animationImages.firstObject.size.height);
    
    // 占位视图
    AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
    placeholderView.indicatorView = indicatorView;
    placeholderView.titleLabel.text = @"Loading ...";
    
    // 绑定事件
    __weak AMKPlaceholderView *weakPlaceholderView = placeholderView;
    [placeholderView.tapGestureRecognizer addActionBlock:^(id  _Nonnull sender) {
        NSLog(@"");
        [weakPlaceholderView show:NO inView:nil animated:YES];
    }];
    return placeholderView;
}

+ (instancetype)loadingViewFor500PX {
    return nil;
}

+ (instancetype)emptyViewFor500PX {
    return nil;
}

#pragma mark - Properties

#pragma mark - Layout Subviews

#pragma mark - Public Methods

// 显示/移除
- (void)show:(BOOL)willShow inView:(UIView *)superview animated:(BOOL)animated {
    if (!superview) {
        superview = [UIApplication sharedApplication].delegate.window;
    }
    
    if (willShow) {
        self.alpha = 0;
        if (self.superview != superview) {
            [self removeFromSuperview];
            [superview addSubview:self];
            
            if ([self.indicatorView conformsToProtocol:@protocol(AMKPlaceholderIndicatorAnimationProtocol)]) {
                [self.indicatorView performSelector:@selector(startAnimating)];
            }
        }
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = willShow ? 1 : 0;
    } completion:^(BOOL finished) {
        self.alpha = willShow ? 1 : 0;
        if (!willShow) {
            [self removeFromSuperview];
            if ([self.indicatorView conformsToProtocol:@protocol(AMKPlaceholderIndicatorAnimationProtocol)]) {
                [self.indicatorView performSelector:@selector(stopAnimating)];
            }
        }
    }];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
