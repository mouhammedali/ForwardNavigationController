#
# Be sure to run `pod lib lint ForwardNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ForwardNavigationController'
  s.version          = '0.2.0'
  s.summary          = 'Forward to any popped viewController with familiar slide gesture.'


  s.homepage         = 'https://github.com/mouhammedali/ForwardNavigationController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mouhammedali' => 'mouhammedaliamer@gmail.com' }
  s.source           = { :git => 'https://github.com/mouhammedali/ForwardNavigationController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_versions = '4.0'
  s.source_files = 'ForwardNavigationController/Classes/**/*'

end
