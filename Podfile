# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'FoodSwift' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  swift_version = '5.0'
  
  # Pods for FoodSwift
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'AlamofireNetworkActivityIndicator'
  pod 'ObjectMapper'
  
  # Utils
  pod 'SwiftLint' # A tool to enforce Swift style and conventions.
  pod 'SwifterSwift'
  pod 'SDWebImage'
  pod 'SVProgressHUD'
  pod 'RealmSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'SkeletonView'
  pod 'GoogleSignIn'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'FirebaseFirestore'
  pod 'Firebase/Storage'
  
  
  target 'FoodSwiftTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Nimble' #
  end
  
  target 'FoodSwiftUITests' do
    # Pods for testing
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
