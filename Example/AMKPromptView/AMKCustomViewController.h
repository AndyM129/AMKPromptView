//
//  AMKCustomViewController.h
//  AMKPromptView_Example
//
//  Created by 孟昕欣 on 2019/7/4.
//  Copyright © 2019 https://github.com/AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMKPromptView+Factory.h"

/// 自定义页面，查看不同样式的提示视图
@interface AMKCustomViewController : UIViewController

- (instancetype)initWithPromptType:(AMKPromptType)promptType;

@end
