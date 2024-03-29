Pod::Spec.new do |s|
  s.name          = "Alto"
  s.version       = "1.5.0"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.summary       = "Create adaptive layouts with an expressive yet concise syntax."
  s.homepage      = "https://github.com/marcbaldwin/Alto"
  s.author        = { "marcbaldwin" => "marc.baldwin88@gmail.com" }
  s.source        = { :git => "https://github.com/marcbaldwin/Alto.git", :tag => s.version }
  s.source_files  = "Alto/*.swift"
  s.platform      = :ios, '9.0'
  s.frameworks    = "Foundation", "UIKit"
  s.swift_version = '5.0'
end
