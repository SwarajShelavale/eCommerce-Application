# Uncomment the next line to define a global platform for your project
  platform :ios, '16.4'

target 'eCommerce Application' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for eCommerce Application
  pod 'Alamofire', '~> 5.6'
  pod 'SwiftyJSON', '~> 5.0'
  pod 'Kingfisher', '~> 4.0'

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

end
