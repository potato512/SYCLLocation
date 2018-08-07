Pod::Spec.new do |s|
  s.name         = "SYCLLocation"
  s.version      = "1.1.0"
  s.summary      = "SYCLLocation used to find your position as easy as possible."
  s.homepage     = "https://github.com/potato512/SYCLLocation"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/potato512/SYCLLocation.git", :tag => "#{s.version}" }
  s.source_files  = "SYCLLocation/*.{h,m}"
  s.framework  = "CoreLocation"
  s.requires_arc = true
end