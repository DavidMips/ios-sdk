#
# Be sure to run `pod lib lint MIPS_iOS_SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MIPS_iOS_SDK'
  s.version          = '0.1.0'
  s.summary          = 'official iOS SDK for MIPS paymemnt services'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/akshar@shyankdev.us/MIPS_iOS_SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'akshar@shyankdev.us' => 'akshar@shyankdev.us' }
  s.source           = { :git => 'https://github.com/akshar@shyankdev.us/MIPS_iOS_SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'MIPS_iOS_SDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MIPS_iOS_SDK' => ['MIPS_iOS_SDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'CryptoSwift', '~> 1.8.2'

  # pod 'CocoaLumberjack'
  s.dependency 'CocoaLumberjack/Swift'

  s.dependency 'Alamofire'

end
