#
# Be sure to run `pod lib lint LEFrameworks.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'LEFrameworks'
s.version          = '0.3.0'
s.summary          = 'IOS Development Frameworks 公司IOS开发库：自动排版、列表封装、数据模型、第三方富文本（url点击事件）再次封装'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'IOS Development Frameworks 公司IOS开发库：自动排版、列表封装、数据模型、网络库封装
图片选择切割器（ImagePickerWithCropper），
图片选择器（ImagePicker），
图片切割器（ImageCropper），
弹出消息（LocalNotification），
二维码扫码（LEScanQRCode），
弹窗（LEPopup）、
应用级图片缓存（LEImageCache），
Badge（LEBadge），
蓝牙封装（LEBlueTooth），
电池上涨动画（LEWaveProgressView）'

s.homepage         = 'https://github.com/LarryEmerson/LEFrameworks'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'LarryEmerson' => 'larryemerson@163.com' }
s.source           = { :git => 'https://github.com/LarryEmerson/LEFrameworks.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '7.0'
s.resource_bundles = {
'LEFrameworks' => ['LEFrameworks/Assets/LEFrameworks.bundle/*.png']
}
s.source_files = 'LEFrameworks/Classes/**/*'
# s.public_header_files = 'Pod/Classes/**/*.h'

end
