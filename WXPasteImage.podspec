
Pod::Spec.new do |s|
  s.name         = "WXPasteImage"
  s.version      = "0.0.1"
  s.summary      = "WXPasteImage is paste image to show"
  s.homepage     = "https://github.com/Jifeng2015/WXPasteImage"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "windyer" => "1033147540@qq.com" }
  s.ios.deployment_target = "8.0"
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/Jifeng2015/WXPasteImage.git", :tag => s.version.to_s }
  s.source_files = "WXPasteImage/ViewController.swift"
  s.requires_arc = true
end
