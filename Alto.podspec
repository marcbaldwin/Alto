Pod::Spec.new do |s|
  s.name         = "Alto"
  s.version      = "1.0.0"
  s.license      = "MIT"
  s.summary      = "Create adaptive layouts with an expressive yet concise syntax."
  s.homepage     = "https://github.com/marcbaldwin/AutoLayoutBuilder"
  s.author       = { "marcbaldwin" => "marc.baldwin88@gmail.com" }
  s.source       = { :git => "https://github.com/marcbaldwin/AutoLayoutBuilder.git", :tag => s.version }
  s.source_files = "Alto/*.swift"
  s.platform     = :ios, '8.0'
  s.frameworks   = "Foundation", "UIKit"
  s.requires_arc = true
end