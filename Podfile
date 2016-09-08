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
    pod 'Nimble', :git => 'https://github.com/TaemoonCho/Nimble.git', :tag => 'v3.2.1'

    pod 'RxBlocking', '~> 2.6'
    pod 'RxTests',    '~> 2.6'
end

def ui_pods
    pod 'ActionSheetPicker-3.0', '~> 2.2.0'
    pod 'SwiftLoader'
end

def base_pods
	pod 'RxSwift',    '~> 2.6'
    pod 'RxCocoa',    '~> 2.6'

    pod 'SwiftyJSON'
    pod 'SwiftDate'
    pod 'Alamofire', '~> 2.0'
    pod 'AlamofireImage', :git => 'https://github.com/Alamofire/AlamofireImage.git', :tag => '1.1.2'
    # pod 'RxAlamofire'
end

target 'FlickrSlideAlbum' do
    ui_pods
    base_pods
end

target 'FlickrSlideAlbumTests' do
    base_pods
    testing_pods
end

#target 'FlickrSlideAlbumUITests' do
#	ui_pods
#	base_pods
#	testing_pods
#end

