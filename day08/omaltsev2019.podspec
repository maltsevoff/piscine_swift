#
# Be sure to run `pod lib lint omaltsev2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'omaltsev2019'
  s.version          = '0.1.0'
  s.summary          = 'I just try to make this day.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: A few words about my program. It works correctly. Dont worry. Just dont try to crash it.
                       DESC

  s.homepage         = 'https://github.com/maltsevoff'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
   s.author           = { 'maltsevoff' => 'omaltsev@student.unit.ua' }
   s.source           = { :git => 'https://github.com/maltsevoff/omaltsev2019.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.2'

  s.source_files = 'omaltsev2019/Classes/**/*'
  
  # s.resource_bundles = {
  #   'omaltsev2019' => ['omaltsev2019/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.frameworks = 'UIKit', 'CoreData'
  s.swift_version = '5.0'
  # s.dependency 'AFNetworking', '~> 2.3'
end
