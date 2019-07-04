//
//  AMKPromptView+Factory.h
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/3.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import <AMKPromptView/AMKPromptView.h>
#import "AMKPlaceholderView+Factory.h"

typedef NS_ENUM(NSInteger, AMKPromptType) {
    AMKPromptTypeEmptyViewForNoColorsLoaded = 0,        //!< 显示占位视图到 self.view 上
    AMKPromptTypeEmptyViewForNoColorsLoadedInWindow,    //!< 显示占位视图到 Window 上
    AMKPromptTypeLoadingViewWithActivityIndicator,      //!<
    AMKPromptTypeLoadingViewWithGif,                    //!<
    AMKPromptTypeCountInSectionOne,                     //!< 计数
    AMKPromptTypeDemo,                                  //!<
    AMKPromptType500PX,                                 //!<
    AMKPromptTypeCountInSectionTwo,                     //!< 计数
};

/// 提示视图：工厂类
@interface AMKPromptView (Factory)
+ (instancetype)promptViewForDemo;
+ (instancetype)promptViewFor500PX;

@end
