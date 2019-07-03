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
+ (instancetype)placeholderViewForDemo; //!< 演示

#pragma mark -

- (void)show:(BOOL)willShow inView:(UIView *)superview animated:(BOOL)animated;

@end
