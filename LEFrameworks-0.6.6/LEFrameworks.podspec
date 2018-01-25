Pod::Spec.new do |s|
  s.name = "LEFrameworks"
  s.version = "0.6.6"
  s.summary = "LarryEmerson \u4E4B IOS \u57FA\u7840\u5C01\u88C5"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"LarryEmerson"=>"larryemerson@163.com"}
  s.homepage = "https://github.com/LarryEmerson/LEFrameworks"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '7.0'
  s.ios.vendored_framework   = 'ios/LEFrameworks.framework'
end
