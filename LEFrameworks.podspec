Pod::Spec.new do |s|
s.name             = 'LEFrameworks'
s.version          = '0.4.9'
s.summary          = 'LarryEmerson 之 IOS 基础封装'
s.homepage         = 'https://github.com/LarryEmerson/LEFrameworks'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'LarryEmerson' => 'larryemerson@163.com' }
s.source           = { :git => 'https://github.com/LarryEmerson/LEFrameworks.git', :tag => s.version.to_s }
s.ios.deployment_target = '7.0'
s.resource_bundles = {
'LEFrameworks' => ['LEFrameworks/LEFrameworksRes/LEFrameworks.bundle/*.png']
}
s.source_files = 'LEFrameworks/Classes/**/*.{h,m}'
end
