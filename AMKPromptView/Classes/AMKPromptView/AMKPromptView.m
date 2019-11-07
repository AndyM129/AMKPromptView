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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.animationDuration = [AMKPromptView appearance].animationDuration>0 ? [AMKPromptView appearance].animationDuration : 0.15;
    }
    return self;
}

- (instancetype _Nullable)initWithDelegate:(id<AMKPromptViewDelegate>)delegate {
    if (self = [self initWithFrame:CGRectZero]) {
        self.delegate = delegate;
    }
    return self;
}

+ (instancetype _Nullable)promptViewWithDelegate:(id<AMKPromptViewDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

#pragma mark - Layout Subviews

#pragma mark - Properties

- (AMKPlaceholderView *)restrictedView {
    if (!_restrictedView) {
        [self setRestrictedView:[AMKPlaceholderView.alloc init]];
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
        [self addTargetActionToPlaceholderView:_restrictedView];
    }
}

- (AMKPlaceholderView *)loadingView {
    if (!_loadingView) {
        [self setLoadingView:[AMKPlaceholderView.alloc init]];
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
        [self addTargetActionToPlaceholderView:_loadingView];
    }
}

- (AMKPlaceholderView *)emptyView {
    if (!_emptyView) {
        [self setEmptyView:[AMKPlaceholderView.alloc init]];
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
        [self addTargetActionToPlaceholderView:_emptyView];
    }
}

- (AMKPlaceholderView *)errorView {
    if (!_errorView) {
        [self setErrorView:[AMKPlaceholderView.alloc init]];
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
        [self addTargetActionToPlaceholderView:_errorView];
    }
}

- (void)setStatus:(AMKPromptStatus)status {
    [self setStatus:status animated:NO completion:nil];
}

#ifdef DEBUG

- (AMKPromptStatus)nextStatus {
    AMKPromptStatus nextStatus = self.status;
    do {
        nextStatus = (nextStatus+1) % (AMKPromptStatusEmpty+1);
        if (nextStatus==AMKPromptStatusHidden) break;
        if (nextStatus==AMKPromptStatusRestricted && _restrictedView) break;
        if (nextStatus==AMKPromptStatusLoading && _loadingView) break;
        if (nextStatus==AMKPromptStatusError && _errorView) break;
        if (nextStatus==AMKPromptStatusEmpty && _emptyView) break;
    } while (YES);
    return nextStatus;
}

#endif

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
- (void)addTargetActionToPlaceholderView:(AMKPlaceholderView *)placeholderView {
    [placeholderView.button addTarget:self action:@selector(didClickPlaceholderViewButton:) forControlEvents:UIControlEventTouchUpInside];
    [placeholderView.tapGestureRecognizer addTarget:self action:@selector(didTapPlaceholderView:)];
}

- (void)didClickPlaceholderViewButton:(UIButton *)button {
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(promptView:didClickPlaceholderView:inStatus:)]) return;
    
    AMKPlaceholderView *placeholderView = (AMKPlaceholderView *)[self superviewOfView:button inClass:AMKPlaceholderView.class];
    [self.delegate promptView:self didClickPlaceholderView:placeholderView inStatus:self.status];
}

- (void)didTapPlaceholderView:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(promptView:didTapPlaceholderView:inStatus:)]) return;
    
    AMKPlaceholderView *placeholderView = (AMKPlaceholderView *)[self superviewOfView:tapGestureRecognizer.view inClass:AMKPlaceholderView.class];
    [self.delegate promptView:self didTapPlaceholderView:placeholderView inStatus:self.status];
}


#pragma mark - Override

#pragma mark - Delegate

#pragma mark - Helper Methods

/// 获取某视图的 指定类型的父视图
- (UIView *)superviewOfView:(UIView *)view inClass:(Class)class {
    UIView *superview = view;
    do {
        if ([superview isKindOfClass:class]) return superview;
        superview = [superview superview];
    } while (superview != nil);
    return nil;
}

@end



