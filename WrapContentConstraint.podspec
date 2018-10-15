Pod::Spec.new do |spec|
  spec.name          = 'WrapContentConstraint'
  spec.homepage      = "https://github.com/Machipla/WrapContentConstraint"
  spec.version       = '0.0.1'
  spec.platform      = :ios, "9.0"
  spec.authors       = 'Mario Chinchilla'
  spec.summary       = 'Finally a constraint that wraps the content when necessary!'
  spec.license       = { :type => "MIT", :file => "LICENSE.md" }
  spec.source        = { :git => 'https://github.com/Machipla/WrapContentConstraint.git', :tag => "#{spec.version}" }
  spec.swift_version = '4.0'

  spec.source_files = 'Sources/**/*.{swift}'
  spec.frameworks   = 'Foundation', 'UIKit'
end