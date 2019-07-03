//
//  AMKPlaceholderView.m
//  Pods
//
//  Created by Andy on 2017/11/4.
//

#import "AMKPlaceholderView.h"
#import <Masonry/Masonry.h>

static BOOL kDebugEnable = NO;

@interface AMKPlaceholderView () @end

@implementation AMKPlaceholderView
@synthesize contentView = _contentView;
@synthesize titleLabel = _titleLabel;
@synthesize subTitleLabel = _subTitleLabel;
@synthesize button = _button;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;

#pragma mark - Init Methods

- (void)dealloc {
    
}

/// 配置默认样式
+ (void)initialize {
    if (self != AMKPlaceholderView.class) return;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AMKPlaceholderView appearance].contentViewOffset = UIOffsetMake(0, 0);
        [AMKPlaceholderView appearance].contentViewEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
        [AMKPlaceholderView appearance].indicatorViewMarginBottom = 15;
        [AMKPlaceholderView appearance].titleLabelMarginBottom = 15;
        [AMKPlaceholderView appearance].titleLabelTextFont = [UIFont systemFontOfSize:13];
        [AMKPlaceholderView appearance].titleLabelTextColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
        [AMKPlaceholderView appearance].subTitleLabelMarginBottom = 5;
        [AMKPlaceholderView appearance].subTitleLabelTextFont = [UIFont systemFontOfSize:13];
        [AMKPlaceholderView appearance].subTitleLabelTextColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    });
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentViewEdgeInsets = [AMKPlaceholderView appearance].contentViewEdgeInsets;
        self.indicatorViewMarginBottom = [AMKPlaceholderView appearance].indicatorViewMarginBottom;
        self.titleLabelMarginBottom = [AMKPlaceholderView appearance].titleLabelMarginBottom;
        self.titleLabelTextFont = [AMKPlaceholderView appearance].titleLabelTextFont;
        self.titleLabelTextColor = [AMKPlaceholderView appearance].titleLabelTextColor;
        self.subTitleLabelMarginBottom = [AMKPlaceholderView appearance].subTitleLabelMarginBottom;
        self.subTitleLabelTextFont = [AMKPlaceholderView appearance].subTitleLabelTextFont;
        self.subTitleLabelTextColor = [AMKPlaceholderView appearance].subTitleLabelTextColor;
        [self contentView];
    }
    return self;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)relayoutSubviews {
    UIView *lastView = nil;
    MASViewAttribute *lastViewAttribute = nil;
    CGFloat lastMarginBottom = 0;
    
    // 内容视图
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self->_contentView.frame.size.width) {
            make.width.mas_equalTo(self->_contentView.frame.size.width);
        } else {
            make.width.mas_equalTo(self).offset(-40);
        }
        if (self->_contentView.frame.size.height) {
            make.height.mas_equalTo(self->_contentView.frame.size.height);
        }
        make.centerX.mas_equalTo(self).offset(self->_contentViewOffset.horizontal);
        make.centerY.mas_equalTo(self).offset(self->_contentViewOffset.vertical);
    }];
    lastViewAttribute = _contentView.mas_top;
    lastMarginBottom = _contentViewEdgeInsets.top;
    
    // 提示视图
    if (_indicatorView) {
        [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_contentView).offset(lastMarginBottom);
            make.size.mas_equalTo(self->_indicatorView.frame.size);
            make.centerX.mas_equalTo(self->_contentView);
        }];
        lastView = _indicatorView;
        lastViewAttribute = _indicatorView.mas_bottom;
        lastMarginBottom = _indicatorViewMarginBottom;
    }
    
    // 标题视图
    if (_titleLabel) {
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self->_titleLabel.frame.size.width) {
                make.width.mas_equalTo(self->_titleLabel.frame.size.width);
            }
            if (self->_titleLabel.frame.size.height) {
                make.height.mas_equalTo(self->_titleLabel.frame.size.height);
            }
            make.top.mas_equalTo(lastViewAttribute).offset(lastMarginBottom);
            make.centerX.mas_equalTo(self->_contentView);
        }];
        lastView = _titleLabel;
        lastViewAttribute = _titleLabel.mas_bottom;
        lastMarginBottom = _titleLabelMarginBottom;
    }
    
    // 子标题视图
    if (_subTitleLabel) {
        [_subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self->_subTitleLabel.frame.size.width) {
                make.width.mas_equalTo(self->_subTitleLabel.frame.size.width);
            }
            if (self->_subTitleLabel.frame.size.height) {
                make.height.mas_equalTo(self->_subTitleLabel.frame.size.height);
            }
            make.top.mas_equalTo(lastViewAttribute).offset(lastMarginBottom);
            make.width.mas_lessThanOrEqualTo(self->_contentView);
            make.centerX.mas_equalTo(self->_contentView);
        }];
        lastView = _subTitleLabel;
        lastViewAttribute = _subTitleLabel.mas_bottom;
        lastMarginBottom = _subTitleLabelMarginBottom;
    }
    
    // 按钮
    if (_button) {
        [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self->_button.frame.size.width) {
                make.width.mas_equalTo(self->_button.frame.size.width);
            }
            if (self->_button.frame.size.height) {
                make.height.mas_equalTo(self->_button.frame.size.height);
            }
            make.top.mas_equalTo(lastViewAttribute).offset(lastMarginBottom);
            make.centerX.mas_equalTo(self->_contentView);
        }];
        lastView = _button;
        lastViewAttribute = _button.mas_bottom;
        lastMarginBottom = 0;
    }
    
    // 自动包裹内容视图
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self->_contentView).offset(-self->_contentViewEdgeInsets.bottom);
    }];
}

#pragma mark - Properties

- (void)setContentViewOffset:(UIOffset)contentViewOffset {
    if (!UIOffsetEqualToOffset(_contentViewOffset, contentViewOffset)) {
        _contentViewOffset = contentViewOffset;
        if (self.window) {
            [self relayoutSubviews];
        }
    }
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)setContentView:(UIView *)contentView {
    if (![_contentView isEqual:contentView]) {
        if (_contentView && _contentView.superview && [_contentView.superview isEqual:self]) {
            [_contentView removeFromSuperview];
        }
        if (contentView && contentView.superview) {
            [_contentView removeFromSuperview];
        }
        _contentView = contentView;
        [self.contentView addSubview:_contentView];
        if (self.window) {
            [self relayoutSubviews];
        }
    }
}

- (void)setIndicatorView:(UIView *)indicatorView {
    if (![_indicatorView isEqual:indicatorView]) {
        if (_indicatorView && _indicatorView.superview && [_indicatorView.superview isEqual:self]) {
            [_indicatorView removeFromSuperview];
        }
        if (indicatorView && indicatorView.superview) {
            [_indicatorView removeFromSuperview];
        }
        _indicatorView = indicatorView;
        [self.contentView addSubview:_indicatorView];
        if (self.window) {
            [self relayoutSubviews];
        }
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = self.titleLabelTextFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = self.titleLabelTextColor;
        [_contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setTitleLabel:(UILabel *)titleLabel {
    if (![_titleLabel isEqual:titleLabel]) {
        if (_titleLabel && _titleLabel.superview && [_titleLabel.superview isEqual:self]) {
            [_titleLabel removeFromSuperview];
        }
        if (titleLabel && titleLabel.superview) {
            [_titleLabel removeFromSuperview];
        }
        _titleLabel = titleLabel;
        [self.contentView addSubview:_titleLabel];
        if (self.window) {
            [self relayoutSubviews];
        }
    }
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];;
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = self.subTitleLabelTextFont;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = self.subTitleLabelTextColor;
        [_contentView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (void)setSubTitleLabel:(UILabel *)subTitleLabel {
    if (![_subTitleLabel isEqual:subTitleLabel]) {
        if (_subTitleLabel && _subTitleLabel.superview && [_subTitleLabel.superview isEqual:self]) {
            [_subTitleLabel removeFromSuperview];
        }
        if (subTitleLabel && subTitleLabel.superview) {
            [_subTitleLabel removeFromSuperview];
        }
        _subTitleLabel = subTitleLabel;
        [self.contentView addSubview:_subTitleLabel];
        if (self.window) {
            [self relayoutSubviews];
        }
    }
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentView addSubview:_button];
    }
    return _button;
}

- (void)setButton:(UIButton *)button {
    if (![_button isEqual:button]) {
        if (_button && _button.superview && [_button.superview isEqual:self]) {
            [_button removeFromSuperview];
        }
        if (button && button.superview) {
            [_button removeFromSuperview];
        }
        _button = button;
        [self.contentView addSubview:_button];
        if (self.window) {
            [self relayoutSubviews];
        }
    }
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if(!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        _tapGestureRecognizer.numberOfTapsRequired = 1;
        _tapGestureRecognizer.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tapGestureRecognizer];
    }
    return _tapGestureRecognizer;
}

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (_tapGestureRecognizer == tapGestureRecognizer) return;
    _tapGestureRecognizer = tapGestureRecognizer;
    [self addGestureRecognizer:_tapGestureRecognizer];
}

#pragma mark - Actions

#pragma mark - Override

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (!self.superview) return;
    
    [self relayoutSubviews];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    if (!kDebugEnable) return;
    
    CGFloat onePixel = 1.0 / [UIScreen mainScreen].scale;
    self.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.2];
    _contentView.backgroundColor = [UIColor cyanColor];
    _contentView.layer.borderWidth = onePixel;
    _indicatorView.layer.borderWidth = onePixel;
    _titleLabel.layer.borderWidth = onePixel;
    _subTitleLabel.layer.borderWidth = onePixel;
    _button.layer.borderWidth = onePixel;
}

#pragma mark - Delegate

#pragma mark - Helper Methods

@end

@implementation UIImageView(AMKPlaceholderView) @end
@implementation UIActivityIndicatorView(AMKPlaceholderView) @end
@implementation UIImage (AMKPlaceholderView)

+ (UIImage *_Nullable)amkpv_imageWithColor:(UIColor *_Nullable)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [roundedRect fillWithBlendMode:kCGBlendModeNormal alpha:1];
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (nullable NSArray<UIImage *> *)amkpv_imagesWithContentsOfFile:(nullable NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) return nil;
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    CGFloat scale = [UIScreen mainScreen].scale;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i=0; i<count; i++) {
        CGImageRef CGImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:CGImage scale:scale orientation:UIImageOrientationUp];
        [images addObject:image];
        CGImageRelease(CGImage);
    }
    CFRelease(source);
    return images;
}

@end
