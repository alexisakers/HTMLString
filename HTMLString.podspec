Pod::Spec.new do |s|

  s.name         = "HTMLString"
  s.version      = "1.0.2"
  s.summary      = "Convert Strings that contains HTML in Swift"

  s.description  = <<-DESC
HTMLString is a micro-library written in Swift that enables your app to convert Strings that contain HTML. It supports ASCII and Unicode escaping, as well as unescaping. You can use it with 2125 named escape sequences (`&amp;`) as well as with decimal (`&#128;`) and hexadecimal (`&#x1F643;`) sequences.
DESC

  s.homepage     = "https://github.com/alexaubry/HTMLString"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Alexis Aubry Radanovic" => "aleks@alexis-aubry-radanovic.me" }
  s.social_media_url   = "http://twitter.com/leksantoine"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/alexaubry/HTMLString.git", :tag => "#{s.version}" }
  s.source_files  = "Sources"

end
