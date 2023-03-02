# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

workspace 'Fodamy'

# Network
$Alamofire =  pod 'Alamofire', '~> 5.4'

# Helper
$TinyConstraints = pod "TinyConstraints", '~> 4.0'
$IQKeyboardManagerSwift = pod "IQKeyboardManagerSwift", '~> 6.5'
$SwiftLint = pod 'SwiftLint', '~> 0.44'
$MobilliumUserDefaults = pod 'MobilliumUserDefaults', '~> 2.0'
$MobilliumDateFormatter = pod 'MobilliumDateFormatter', '~> 1.2'
$MobilliumBuilders = pod 'MobilliumBuilders', '~> 1.4'
$Segmentio = pod 'Segmentio', '~> 4.1'
$Kingfisher = pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :branch => 'version6-xcode13'
$SwiftEntryKit = pod 'SwiftEntryKit', '~> 1.2'
$SKPhotoBrowser = pod 'SKPhotoBrowser', '~> 7.0'
$KeychainSwift = pod 'KeychainSwift', '~> 19.0'
$SwiftGen = pod 'SwiftGen', '~> 6.5'

target 'Fodamy' do
  
  project 'Fodamy.xcodeproj'

  # Pods for Fodamy
  
  # Network
  $Alamofire
  
  # Helper
  $TinyConstraints
  $IQKeyboardManagerSwift
  $SwiftLint
  $MobilliumUserDefaults
  $MobilliumDateFormatter
  $MobilliumBuilders
  $Segmentio
  $Kingfisher
  $SwiftEntryKit
  $SKPhotoBrowser
  $KeychainSwift
end

target 'DataProvider' do
  
  project 'DataProvider/DataProvider.xcodeproj'
  
  # Pods for DataProvider
  
end

target 'UIComponents' do
  
  project 'UIComponents/UIComponents.xcodeproj'
  
  # Pods for UIComponents
  
  # Helper
  $TinyConstraints
  $SwiftGen
  $MobilliumBuilders
  $Segmentio
  $Kingfisher
  $SwiftEntryKit
  
end

target 'Utilities' do
  
  project 'Utilities/Utilities.xcodeproj'
  
  # Pods for Utilities
  
  # Helper
  $MobilliumUserDefaults
  
end
