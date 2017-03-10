Pod::Spec.new do |s|
  s.name = "LEFrameworks"
  s.version = "0.6.2"
  s.summary = "LarryEmerson \u{4e4b} IOS \u{57fa}\u{7840}\u{5c01}\u{88c5}"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"LarryEmerson"=>"larryemerson@163.com"}
  s.homepage = "https://github.com/LarryEmerson/LEFrameworks"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '7.0'
  s.ios.vendored_framework   = 'ios/LEFrameworks.framework'
end
