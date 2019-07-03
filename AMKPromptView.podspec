#
# Be sure to run `pod lib lint AMKPromptView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AMKPromptView'
  s.version          = '0.1.0'
  s.summary          = 'AMKPromptView'
  s.description      = <<-DESC
                       The dispatcher with no regist process to split your iOS Project into multiple project.
                       DESC
  s.homepage         = 'https://github.com/AndyM129/AMKPromptView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andy__M' => 'andy_m129@163.com' }
  s.source           = { :git => 'https://github.com/AndyM129/AMKPromptView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.default_subspec = 'AMKPromptView'

  s.subspec 'AMKPromptView' do |promptView|
      promptView.source_files = 'AMKPromptView/Classes/PromptView/*.{h,m}'
      promptView.dependency 'AMKPromptView/AMKPlaceholderView'
  end

  s.subspec 'AMKPlaceholderView' do |placeholderView|
      placeholderView.source_files = 'AMKPromptView/Classes/PlaceholderView/*.{h,m}'
      placeholderView.dependency 'Masonry'
  end

end
