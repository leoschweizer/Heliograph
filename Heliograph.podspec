Pod::Spec.new do |s|
  
  s.name         = 'Heliograph'
  s.version      = '0.1.0'
  s.summary      = 'Mirror-based reflection for Objective-C'
  s.description  = <<-DESC
                     Heliograph is an object-oriented, mirror-based wrapper around Objective-C's
                     runtime reflection capabilities.
                   DESC
  s.homepage     = 'https://github.com/leoschweizer/Heliograph'
  s.social_media_url = 'https://twitter.com/leoschweizer' 
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'Leo Schweizer' => 'leonhard.schweizer@gmail.com' }
  s.source       = { :git => 'https://github.com/leoschweizer/Heliograph.git', :tag => s.version }

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'

  s.requires_arc = true

  s.source_files = 'Lib', 'Lib/**/*.{h,m}'
  
end
