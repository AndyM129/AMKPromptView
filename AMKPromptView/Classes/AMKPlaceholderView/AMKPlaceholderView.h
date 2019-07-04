//
//  AMKPlaceholderView.h
//  Pods
//
//  Created by Andy on 2017/11/4.
//

#import <UIKit/UIKit.h>

/// 占位视图
@interface AMKPlaceholderView : UIView
@property(nonatomic, strong, nullable) UIView *contentView;                                     //!< 内容视图(可指定该视图height或width, 取0则为自动布局)
@property(nonatomic, assign) UIOffset contentViewOffset UI_APPEARANCE_SELECTOR;                 //!< 内容视图距中的偏移
@property(nonatomic, assign) UIEdgeInsets contentViewEdgeInsets UI_APPEARANCE_SELECTOR;         //!< 内容视图内边距
@property(nonatomic, strong, nullable) UIView *indicatorView;                                   //!< 提示视图（须指定frame.size）
@property(nonatomic, assign) CGFloat indicatorViewMarginBottom;                                 //!< 提示视图底部外边距
@property(nonatomic, strong, nullable) UILabel *titleLabel;                                     //!< 标题
@property(nonatomic, assign) CGFloat titleLabelMarginBottom;                                    //!< 标题底部外边距
@property(nonatomic, strong, nullable) UIFont *titleLabelTextFont UI_APPEARANCE_SELECTOR;       //!< 标题字体
@property(nonatomic, strong, nullable) UIColor *titleLabelTextColor UI_APPEARANCE_SELECTOR;     //!< 标题字体颜色
@property(nonatomic, strong, nullable) UILabel *subTitleLabel;                                  //!< 子标题
@property(nonatomic, assign) CGFloat subTitleLabelMarginBottom;                                 //!< 子标题底部外边距
@property(nonatomic, strong, nullable) UIFont *subTitleLabelTextFont UI_APPEARANCE_SELECTOR;    //!< 子标题字体
@property(nonatomic, strong, nullable) UIColor *subTitleLabelTextColor UI_APPEARANCE_SELECTOR;  //!< 子标题字体颜色
@property(nonatomic, strong, nullable) UIButton *button;                                        //!< 操作按钮
@property(nonatomic, strong, nullable) UITapGestureRecognizer *tapGestureRecognizer;            //!< tap手势
@end

#pragma mark -

/// 占位视图：子类重写、定制
@interface AMKPlaceholderView (UISubclassingHooks)

/// 根据约束更新布局，如需自定义布局，可重写该方法
- (void)relayoutSubviews;

@end

#pragma mark -

/// 占位指示视图的动画协议
@protocol AMKPlaceholderIndicatorAnimationProtocol <NSObject>
@required
- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;
@end

#pragma mark -

/// UIImageView 默认支持 AMKPlaceholderIndicatorAnimationProtocol协议
@interface UIImageView (AMKPlaceholderView) <AMKPlaceholderIndicatorAnimationProtocol> @end

#pragma mark -

/// UIActivityIndicatorView 默认支持 AMKPlaceholderIndicatorAnimationProtocol协议
@interface UIActivityIndicatorView (AMKPlaceholderView) <AMKPlaceholderIndicatorAnimationProtocol> @end

#pragma mark -

@interface UIImage (AMKPlaceholderView)

/// 以指定颜色、大小、圆角 生成图片
+ (UIImage *_Nullable)amkpv_imageWithColor:(UIColor *_Nullable)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/// 加载指定路径的图片数组（即 gif图）
+ (nullable NSArray<UIImage *> *)amkpv_imagesWithContentsOfFile:(nullable NSString *)path;

@end
