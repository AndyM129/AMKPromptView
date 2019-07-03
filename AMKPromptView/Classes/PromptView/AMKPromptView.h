//
//  AMKPromptView.h
//  Pods
//
//  Created by Andy on 2017/11/4.
//

#import <UIKit/UIKit.h>
#import "AMKPlaceholderView.h"
@class AMKPromptView;

/** 提示状态 */
typedef NS_ENUM(NSInteger, AMKPromptStatus) {
    AMKPromptStatusHidden = 0,  //!< 无提示视图
    AMKPromptStatusRestricted,  //!< 未授权提示（如未登录）
    AMKPromptStatusLoading,     //!< 加载提示
    AMKPromptStatusError,       //!< 错误提示
    AMKPromptStatusEmpty        //!< 空内容提示
};


/** 提示视图回调 */
typedef void(^AMKPromptViewCompletionBlock)(AMKPromptView *promptView, BOOL finished);

/** 提示视图 */
@interface AMKPromptView : UIView
@property(nonatomic, strong) AMKPlaceholderView *restrictedView; //!< 未授权提示视图
@property(nonatomic, strong) AMKPlaceholderView *loadingView;    //!< 加载视图
@property(nonatomic, strong) AMKPlaceholderView *errorView;      //!< 错误视图
@property(nonatomic, strong) AMKPlaceholderView *emptyView;      //!< 空数据视图
@property(nonatomic, assign) AMKPromptStatus status;             //!< 提示状态
@property(nonatomic, assign) NSTimeInterval animationDuration UI_APPEARANCE_SELECTOR;  //!< 动画时长，默认0.3s

- (void)setStatus:(AMKPromptStatus)status animated:(BOOL)animated completion:(AMKPromptViewCompletionBlock)completion;    //!< 修改提示状态
@end

#ifdef DEBUG

/// 调试
@interface AMKPromptView (Debug)
@property(nonatomic, readonly) AMKPromptStatus nextStatus;       /// 下一个有效的提示状态
@end

#endif


