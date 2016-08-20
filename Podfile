# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

post_install do | installer |
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
end

use_frameworks!

def testing_pods
    pod 'Quick', :git => 'https://github.com/Quick/Quick', :tag => 'v0.9.0'
    pod 'Nimble', :git => 'https://github.com/Quick/Nimble', :tag => 'v3.2.0'
    pod 'SwiftyJSON'
    pod 'SwiftDate'
end

target 'FlickrSlideAlbum' do
    pod 'SwiftyJSON'
    pod 'SwiftDate'
end

target 'FlickrSlideAlbumTests' do
    testing_pods
  end

  target 'FlickrSlideAlbumUITests' do
    # Pods for testing
    testing_pods
  end

