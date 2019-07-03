//
//  AMKPromptView.m
//  Pods
//
//  Created by Andy on 2017/11/4.
//

#import "AMKPromptView.h"
#import <Masonry/Masonry.h>


@implementation AMKPromptView
@synthesize restrictedView = _restrictedView;
@synthesize loadingView = _loadingView;
@synthesize errorView = _errorView;
@synthesize emptyView = _emptyView;

#pragma mark - Init Methods

- (void)dealloc {
    
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AMKPromptView appearance].animationDuration = 0.15;
    });
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.animationDuration = [AMKPromptView appearance].animationDuration;
    }
    return self;
}

#pragma mark - Layout Subviews

#pragma mark - Properties

- (AMKPlaceholderView *)restrictedView {
    if (!_restrictedView) {
        _restrictedView = [[AMKPlaceholderView alloc] init];
        _restrictedView.alpha = 0;
        [self addSubview:_restrictedView];
    }
    return _restrictedView;
}

- (void)setRestrictedView:(AMKPlaceholderView *)restrictedView {
    if (![_restrictedView isEqual:restrictedView]) {
        [restrictedView removeFromSuperview];
        [_restrictedView removeFromSuperview];
        
        _restrictedView = restrictedView;
        _restrictedView.alpha = 0;
        [self addSubview:_restrictedView];
    }
}

- (AMKPlaceholderView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[AMKPlaceholderView alloc] init];
        _loadingView.alpha = 0;
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

- (void)setLoadingView:(AMKPlaceholderView *)loadingView {
    if (![_loadingView isEqual:loadingView]) {
        [loadingView removeFromSuperview];
        [_loadingView removeFromSuperview];
        
        _loadingView = loadingView;
        _loadingView.alpha = 0;
        [self addSubview:_loadingView];
    }
}

- (AMKPlaceholderView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[AMKPlaceholderView alloc] init];
        _emptyView.alpha = 0;
        [self addSubview:_emptyView];
    }
    return _emptyView;
}

- (void)setEmptyView:(AMKPlaceholderView *)emptyView {
    if (![_emptyView isEqual:emptyView]) {
        [emptyView removeFromSuperview];
        [_emptyView removeFromSuperview];
        
        _emptyView = emptyView;
        _emptyView.alpha = 0;
        [self addSubview:_emptyView];
    }
}

- (AMKPlaceholderView *)errorView {
    if (!_errorView) {
        _errorView = [[AMKPlaceholderView alloc] init];
        _errorView.alpha = 0;
        [self addSubview:_errorView];
    }
    return _errorView;
}

- (void)setErrorView:(AMKPlaceholderView *)errorView {
    if (![_errorView isEqual:errorView]) {
        [errorView removeFromSuperview];
        [_errorView removeFromSuperview];
        
        _errorView = errorView;
        _errorView.alpha = 0;
        [self addSubview:_errorView];
    }
}

- (void)setStatus:(AMKPromptStatus)status {
    [self setStatus:status animated:NO completion:nil];
}

#pragma mark - Actions

- (void)setStatus:(AMKPromptStatus)status animated:(BOOL)animated completion:(AMKPromptViewCompletionBlock _Nullable)completion {
    if (_status != status) {
        [self willChangeValueForKey:@"status"];
        _status = status;
        
        // 置顶显示
        self.hidden = NO;
        if (status != AMKPromptStatusHidden) {
            [self.superview bringSubviewToFront:self];
        }
        
        // 调整动画
        if ([_restrictedView.indicatorView conformsToProtocol:@protocol(AMKPlaceholderIndicatorAnimationProtocol)]) {
            if (_status == AMKPromptStatusRestricted) [_restrictedView.indicatorView performSelector:@selector(startAnimating)];
            else [_restrictedView.indicatorView performSelector:@selector(stopAnimating)];
        }
        if ([_loadingView.indicatorView conformsToProtocol:@protocol(AMKPlaceholderIndicatorAnimationProtocol)]) {
            if (_status == AMKPromptStatusLoading) [_loadingView.indicatorView performSelector:@selector(startAnimating)];
            else [_loadingView.indicatorView performSelector:@selector(stopAnimating)];
        }
        if ([_errorView.indicatorView conformsToProtocol:@protocol(AMKPlaceholderIndicatorAnimationProtocol)]) {
            if (_status == AMKPromptStatusError) [_errorView.indicatorView performSelector:@selector(startAnimating)];
            else [_errorView.indicatorView performSelector:@selector(stopAnimating)];
        }
        if ([_emptyView.indicatorView conformsToProtocol:@protocol(AMKPlaceholderIndicatorAnimationProtocol)]) {
            if (_status == AMKPromptStatusEmpty) [_emptyView.indicatorView performSelector:@selector(startAnimating)];
            else [_emptyView.indicatorView performSelector:@selector(stopAnimating)];
        }
        
        // 调整视图显示
        __weak __typeof(self) weakSelf = self;
        [UIView animateWithDuration:(animated?self.animationDuration:0) animations:^{
            if (!weakSelf) return;
            
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.alpha = (weakSelf.status==AMKPromptStatusHidden) ? 0 : 1;
            strongSelf->_restrictedView.alpha = (weakSelf.status==AMKPromptStatusRestricted) ? 1 : 0;
            strongSelf->_loadingView.alpha = (weakSelf.status==AMKPromptStatusLoading) ? 1 : 0;
            strongSelf->_errorView.alpha = (weakSelf.status==AMKPromptStatusError) ? 1 : 0;
            strongSelf->_emptyView.alpha = (weakSelf.status==AMKPromptStatusEmpty) ? 1 : 0;
        } completion:^(BOOL finished) {
            if (finished) {
                weakSelf.hidden = (weakSelf.status==AMKPromptStatusHidden) ? YES : NO;
            }
            completion==nil ?: completion(weakSelf, finished);
        }];
        [self didChangeValueForKey:@"status"];
    }
}

#pragma mark - Override

#pragma mark - Delegate

#pragma mark - Helper Methods

@end



