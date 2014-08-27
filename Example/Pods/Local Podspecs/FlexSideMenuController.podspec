#
# Be sure to run `pod lib lint FlexSideMenuController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FlexSideMenuController"
  s.version          = "0.1.0"
  s.summary          = "FlexSideMenuController provides capability to add custom animations to be included on side menu display"
  s.description      = <<-DESC
                       FlexSideMenuController provides capability to add custom animations to be included on side menu display. Support for both pop animation and core animations is available in the included library.
                       DESC
  s.homepage         = "https://github.com/boojapathy/FlexSideMenuController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "boojapathy" => "boojapathy@gmail.com" }
  s.source           = { :git => "https://github.com/boojapathy/FlexSideMenuController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'FlexSideMenuController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'pop'
end
