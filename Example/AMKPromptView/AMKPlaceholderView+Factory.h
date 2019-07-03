//
//  AMKPlaceholderView+Factory.h
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/3.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import <AMKPromptView/AMKPlaceholderView.h>
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>

/// 占位视图：工厂类
@interface AMKPlaceholderView (Factory)
+ (instancetype)restrictedView; //!< 权限提示
+ (instancetype)errorView; //!< 错误提示
+ (instancetype)emptyViewForNoColorsLoaded; //!< 空数据提示
+ (instancetype)loadingViewWithActivityIndicator; //!< 加载中提示
+ (instancetype)loadingViewWithGif; //!< 加载中提示

#pragma mark -

- (void)show:(BOOL)willShow inView:(UIView *)superview animated:(BOOL)animated;

@end
