#
#   Created by : Nghia Tran
#
#
source 'https://github.com/CocoaPods/Specs'
platform :ios, '9.0'

workspace 'TwitSplit.xcworkspace'

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

# Pods
def important_pods
  pod 'RxSwift',    '~> 3.0'
  pod 'RxCocoa',    '~> 3.0'
end

# TwitterApp
target "TwitterApp" do
  project 'TwitterApp/TwitterApp.xcodeproj'
  important_pods
end

# TwitterCore
target "TwitterCore" do
  project 'TwitterCore/TwitterCore.xcodeproj'
  important_pods
end

# TwitterCoreTests
target "TwitterCoreTests" do
  project 'TwitterCore/TwitterCore.xcodeproj'
  important_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
end
