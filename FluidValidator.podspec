#
# Be sure to run `pod lib lint FluidValidator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FluidValidator"
  s.version          = "0.1.5"
  s.summary          = "General purpose object validator"

  s.description      = <<-DESC
FluidValidator is intended to encapsulate validation logic. The API was designed with FluentValidation (https://github.com/JeremySkinner/FluentValidation) and Rails Validation as reference.
Currently offers validation of simple objects, complex objects (object graph), enumerables. Localized error messages. You can easly override base behaviors and/or build your own reusable validation rules.
                       DESC

  s.homepage         = "https://github.com/frograin/FluidValidator"
  s.license          = 'MIT'
  s.author           = { "FrogRain" => "info@frograin.com" }
  s.source           = { :git => "https://github.com/frograin/FluidValidator.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource     = 'Pod/FluidValidator.bundle'
end
