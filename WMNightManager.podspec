
Pod::Spec.new do |s|

  s.name         = "WMNightManager"
  s.version      = "1.0.0"
  s.summary      = "为APP增加黑夜模式，支持storyboard"

  s.homepage     = "https://github.com/emilyZhouwm/zhihu"
  s.license      = "MIT"
  s.author       = { "EmilyZhou" => "scarlettzwm@gmail.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/emilyZhouwm/zhihu.git", :tag => "1.0.0" }

  s.source_files  = "WMNightManager/*.{h,m}"

  s.public_header_files = "WMNightManager/*.h"

  s.framework  = "UIKit"
  s.requires_arc = true 

end
