//
//  AMKPromptView.h
//  Pods
//
//  Created by Andy on 2017/11/4.
//

#import <UIKit/UIKit.h>
#import "AMKPlaceholderView.h"
@class AMKPromptView;

/// 提示状态
typedef NS_ENUM(NSInteger, AMKPromptStatus) {
    AMKPromptStatusHidden = 0,  //!< 无提示视图
    AMKPromptStatusRestricted,  //!< 未授权提示（如未登录）
    AMKPromptStatusLoading,     //!< 加载中提示
    AMKPromptStatusError,       //!< 错误提示
    AMKPromptStatusEmpty        //!< 空内容提示
};

/// 提示视图回调
typedef void(^AMKPromptViewCompletionBlock)(AMKPromptView *_Nullable promptView, BOOL finished);

/// 提示视图代理
@protocol AMKPromptViewDelegate <NSObject>
@optional
- (void)promptView:(AMKPromptView *_Nullable)promptView didClickPlaceholderView:(AMKPlaceholderView *_Nullable)placeholderView inStatus:(AMKPromptStatus)status;
- (void)promptView:(AMKPromptView *_Nullable)promptView didTapPlaceholderView:(AMKPlaceholderView *_Nullable)placeholderView inStatus:(AMKPromptStatus)status;
@end

/// 提示视图
@interface AMKPromptView : UIView
@property(nonatomic, strong, nullable) AMKPlaceholderView *restrictedView;              //!< 未授权提示视图
@property(nonatomic, strong, nullable) AMKPlaceholderView *loadingView;                 //!< 加载视图
@property(nonatomic, strong, nullable) AMKPlaceholderView *errorView;                   //!< 错误视图
@property(nonatomic, strong, nullable) AMKPlaceholderView *emptyView;                   //!< 空数据视图
@property(nonatomic, assign) AMKPromptStatus status;                                    //!< 提示状态
@property(nonatomic, assign) NSTimeInterval animationDuration UI_APPEARANCE_SELECTOR;   //!< 动画时长，默认0.3s
@property(nonatomic, weak, nullable) id<AMKPromptViewDelegate> delegate;                //!< 代理

+ (instancetype _Nullable)promptViewWithDelegate:(id<AMKPromptViewDelegate> _Nullable)delegate;
- (instancetype _Nullable)initWithDelegate:(id<AMKPromptViewDelegate> _Nullable)delegate;
- (void)setStatus:(AMKPromptStatus)status animated:(BOOL)animated completion:(AMKPromptViewCompletionBlock _Nullable)completion;    //!< 修改提示状态
@end

#pragma mark -

#ifdef DEBUG

/// 调试
@interface AMKPromptView (Debug)
@property(nonatomic, readonly) AMKPromptStatus nextStatus;                              /// 下一个有效的提示状态
@end

#endif


