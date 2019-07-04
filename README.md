# AMKPromptView

[![CI Status](https://img.shields.io/travis/AndyM129/AMKPromptView.svg?style=flat)](https://travis-ci.org/AndyM129/AMKPromptView)
[![Version](https://img.shields.io/cocoapods/v/AMKPromptView.svg?style=flat)](https://cocoapods.org/pods/AMKPromptView)
[![License](https://img.shields.io/cocoapods/l/AMKPromptView.svg?style=flat)](https://cocoapods.org/pods/AMKPromptView)
[![Platform](https://img.shields.io/cocoapods/p/AMKPromptView.svg?style=flat)](https://cocoapods.org/pods/AMKPromptView)

## Introduction

通常页面的加载都会需要先请求数据，所以会有各种状态，如：

- Restricted：权限受限，如未登录
- Loading：加载中
- Error：数据异常、或网络异常
- Empty：未加载到数据、无数据

所以此时需要一个“提示页"来告知用户当前页面所处的状态，而 `AMKPromptView` 就是用来简化这个步骤的~

## Features

使用该库，可以实现：

- 可快速为 UIViewController 添加页面级提示视图，
  并支持 "未登录、加载中、网络异常、空数据"等状态提示 与 切换；
- 支持各状态提示视图 元素与UI的深度可定制；
- 支持各状态提示视图元素的便捷交互；

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS8+

## Installation

AMKPromptView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
# 使用 VC提示视图扩展
pod 'AMKPromptView/UIViewControllerExtensionMethods' 

# 或使用 占位视图
pod 'AMKPromptView/AMKPlaceholderView' 

# 或使用 提示视图
pod 'AMKPromptView/AMKPromptView' 
```

## Usage

该库包含三个子组件：

- AMKPlaceholderView：占位视图，提供"大图、标题、子标题、按钮"等通用控件的设置&显示，用于表示某一个状态下的占位提示
- AMKPromptView：提示视图，提供包含一组“占位视图”的显隐与状态切换的控制，具体状态如下：
  - Restricted：权限受限，如未登录 等 
  - Loading：加载中 等
  - Error：数据异常、或网络异常 等
  - Empty：未加载到数据、无数据 等
- UIViewControllerExtensionMethods：针对UIViewController添加 `AMKPromptView` 属性的扩展，以便业务方快速接入、使用

下面具体介绍各组件的使用方法：

### 1. `#import <AMKPromptView/AMKPlaceholderView.h>`

示例：

|   ![](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20190704194109.png)   |   ![](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20190704194353.png)   |   ![](https://raw.githubusercontent.com/AndyM129/ImageHosting/master/images/20190704193616.png)   |
| ---- | ---- | ---- |
|   <a href="#loadingplaceholderview">LoadingPlaceholderView</a>  |   <a href="#GifLoadingPlaceholderView">GifLoadingPlaceholderView</a>   |   <a href="#EmptyPlaceholderView">EmptyPlaceholderView</a>   |

#### LoadingPlaceholderView


```objective-c
// 提示视图
UIActivityIndicatorView *indicatorView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

// 占位视图
AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
placeholderView.indicatorView = indicatorView;
placeholderView.titleLabel.text = @"Loading ...";
[self.view addSubview:placeholderView];
```

#### GifLoadingPlaceholderView

```objective-c
// 提示视图
UIImageView *indicatorView = [[UIImageView alloc] init];
indicatorView.animationImages = [UIImage amkpv_imagesWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"amk_placeholder_loading" ofType:@"gif"]];
indicatorView.animationDuration = indicatorView.animationImages.count / 10.0;
indicatorView.frame = CGRectMake(0, 0, indicatorView.animationImages.firstObject.size.width, indicatorView.animationImages.firstObject.size.height);

// 占位视图
AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
placeholderView.indicatorView = indicatorView;
placeholderView.titleLabel.text = @"Loading ...";
[self.view addSubview:placeholderView];
```

#### EmptyPlaceholderView

```objective-c
// 提示视图
UIImage *indicatorImage = [UIImage imageNamed:@"amk_placeholder_empty_colors"];
UIImageView *indicatorView = [[UIImageView alloc] initWithImage:indicatorImage];
indicatorView.frame = CGRectMake(0, 0, indicatorImage.size.width, indicatorImage.size.height);

// 底部按钮
UIColor *normalBackgroundColor = [UIColor colorWithRed:4/255.0 green:125/255.0 blue:254/255.0 alpha:1/1.0];
UIImage *normalBackgroundImage = [UIImage amkpv_imageWithColor:normalBackgroundColor size:CGSizeMake(150, 38) cornerRadius:4];
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
button.frame = CGRectMake(0, 0, normalBackgroundImage.size.width, normalBackgroundImage.size.height);
button.titleLabel.font = [UIFont systemFontOfSize:15];
[button setTitle:@"Go Back" forState:UIControlStateNormal];
[button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];

// 占位视图
AMKPlaceholderView *placeholderView = [AMKPlaceholderView new];
placeholderView.indicatorView = indicatorView;
placeholderView.titleLabel.text = @"No colors loaded";
placeholderView.subTitleLabel.text = @"To show a list of random colors, tap on the refresh icon in the right top corner.\n\nTo clean the list, tap on the trash icon.";
placeholderView.button = button;

// 绑定事件
[placeholderView.button addTarget:self action:@selector(didClickPlaceholderViewButton:) forControlEvents:UIControlEventTouchUpInside];
[placeholderView.tapGestureRecognizer addTarget:self action:@selector(didTapPlaceholderView:)];

// 添加到父视图上
[self.view addSubview:placeholderView];
```

### 2. `#import <AMKPromptView/AMKPromptView.h>`

```objective-c
AMKPromptView *promptView = [AMKPromptView new];
promptView.restrictedView = [AMKPlaceholderView restrictedView];
promptView.loadingView = [AMKPlaceholderView loadingViewWithGif];
promptView.errorView = [AMKPlaceholderView errorView];
promptView.emptyView = [AMKPlaceholderView emptyViewForNoColorsLoaded];
[self.view addSubview:promptView];
[promptView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(UIEdgeInsetsZero);
}];
[promptView setStatus:AMKPromptStatusLoading animated:YES completion:nil];
```

### 3. `#import <AMKPromptView/UIViewController+AMKPromptView.h>`

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIViewController+AMKPromptView";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 按需设置提示页状态
    [self.amk_promptView setStatus:AMKPromptStatusLoading animated:YES completion:nil];
}

#pragma mark AMKPromptViewDelegate

/// 点击提示视图后的处理
- (void)promptView:(AMKPromptView *)promptView didClickPlaceholderView:(AMKPlaceholderView * _Nullable)placeholderView inStatus:(AMKPromptStatus)status {

}

/// 点击提示视图中按钮后的处理
- (void)promptView:(AMKPromptView *)promptView didTapPlaceholderView:(AMKPlaceholderView *)placeholderView inStatus:(AMKPromptStatus)status {
    
}

#pragma mark - Override

/// 按需自定义提示视图在各状态下的占位视图
- (AMKPlaceholderView *)amk_placeholderViewWithPromptStatus:(AMKPromptStatus)status {
    AMKPlaceholderView *placeholderView = nil;
    if (status == AMKPromptStatusError) {
        UIImage *indicatorImage = [UIImage imageNamed:@"amk_placeholder_error_network"];
        UIImageView *indicatorView = [[UIImageView alloc] initWithImage:indicatorImage];
        indicatorView.frame = CGRectMake(0, 0, indicatorImage.size.width, indicatorImage.size.height);
        placeholderView = [[AMKPlaceholderView alloc] init];
        placeholderView.indicatorView = indicatorView;
    }
    else if (status == AMKPromptStatusEmpty) {
        UIImage *indicatorImage = [UIImage imageNamed:@"amk_placeholder_empty_books"];
        UIImageView *indicatorView = [[UIImageView alloc] initWithImage:indicatorImage];
        placeholderView = [[AMKPlaceholderView alloc] init];
        indicatorView.frame = CGRectMake(0, 0, indicatorImage.size.width, indicatorImage.size.height);
        placeholderView.indicatorView = indicatorView;
    }
    return placeholderView;
}
```

### 4. 小提示

如果想要在使用过程中去掉`amk_`前缀，可以通过添加 `AMKPV_SHORTHAND_GLOBALS` 宏来实现，具体方法如下：

1. 在 `工程 -> Biuld Settings ->Preprocessor Macros` 中添加 `AMKPV_SHORTHAND_GLOBALS=1`
2. 如果Pod工程中也有用到该类，须在 `Podfile` 文件中添加如下代码
	```ruby
	post_install do |installer|
	  installer.pods_project.targets.each do |target|
	    target.build_configurations.each do |config|
	      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) COCOAPODS=1 AMKPV_SHORTHAND_GLOBALS=1'
	    end
	  end
	end
	```

## Author

AndyM129, andy_m129@163.com

## License

AMKPromptView is available under the MIT license. See the LICENSE file for more info.
