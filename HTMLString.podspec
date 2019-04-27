Pod::Spec.new do |s|
  s.name         = "HTMLString"
  s.version      = "5.0.0"
  s.summary      = "Escape and unescape HTML entities in Swift"
  s.description  = <<-DESC
HTMLString is a fast library written in Swift that enables your program to add and remove HTML entities in Strings. It supports both ASCII and Unicode. You can use it with 2125 named (`&amp;`), decimal (`&#128;`) and hexadecimal (`&#x1F643;`) entities. It has native support for Swift's Extended Grapheme Clusters. Fully unit tested and documented.
DESC
  
  s.homepage     = "https://github.com/alexaubry/HTMLString"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexis Aubry" => "me@alexaubry.fr" }
  s.social_media_url   = "https://twitter.com/_alexaubry"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/alexaubry/HTMLString.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/HTMLString/*.swift"
  s.documentation_url = "https://alexaubry.github.io/HTMLString/"

  s.swift_version = "5.0"
end
