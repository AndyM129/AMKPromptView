//
//  UIViewController+AMKPromptView.h
//  AMKPromptView
//
//  Created by 孟昕欣 on 2019/7/4.
//

#import <UIKit/UIKit.h>
#import "AMKPromptView.h"

/// 视图控制器：提示视图扩展
@interface UIViewController (AMKPromptView) <AMKPromptViewDelegate>

/// 提示视图
@property(nonatomic, strong, nullable) AMKPromptView *amk_promptView;

#pragma mark - Subclassing Hooks

/// 由子类重写，定制对应状态下的提示视图
- (AMKPlaceholderView *_Nullable)amk_placeholderViewWithPromptStatus:(AMKPromptStatus)status;

@end
