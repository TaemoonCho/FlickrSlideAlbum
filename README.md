# FlickrSliderAlbum

Homework Test 제출용으로 작성한 앱.  
Flickr 공개 피드의 이미지를 하나씩 보여주는 전자앨범.  
  

## Features

* 하나의 이미지에서 머무는 시간을 1 - 10초로 결정할 수 있다. (기본값 : 5초)  
* 다음 이미지 전환시 Fade out/in 애니메이션이 적용되어 있다.  
* 구동 중 백그라운드에서 적절한 양의 추가 피드와 해당 피드의 이미지를 다운로드 하고 있다.  
* Universal앱으로 아이폰과 아이패드에서 동작하며 모든 사이즈에 대응한다.

## Environment
> **아래 버전들은 다음에 나올 의존성을 가진 라이브러리들과 연관이 있으니 주의.**

- Xcode 7.2.1
- OS X Yosemite 10.10.5 
- Swift 2.1.1 (x86_64-apple-darwin14.5.0)
- cocoapod 1.0.1
 
## Dependencies (cocoapod)
  
** 모든 라이브러리가 위의 환경에 맞춰 빌드됨에 주의하세요. **  

- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)  
	: swift 계열에서 가장 인기가 좋은 json 라이브러리. json을 파싱해 model의 instance로 만들 때 사용한다.
- [SwiftDate](https://github.com/malcommac/SwiftDate)  
	: NSDate와 NSDateFomatter의 wrapper. Feed 모델 json deserializing 할 때 사용하지만 요구사항과 큰 관계없다.
- [Alamofire 2.0.2](https://github.com/Alamofire/Alamofire/blob/2.0.2/  
README.md)  
	: Networking 라이브러리 (aka AFNetworking). HTTP 요청시 사용한다.
- [AlamofireImage (tag: 1.1.2)](https://github.com/Alamofire/AlamofireImage)  
	: Alamofire의 이미지 관련 extention. http response body의 이미지를 가져오는데 사용한다.
- [ActionSheetPicker](https://github.com/skywinder/ActionSheetPicker-3.0)  
	: UIActionSheet + UIPickerView wrapper. 첫 화면에서 이미지 지연시간을 결정할 때 사용된다.
- [SwiftLoader](https://github.com/leoru/SwiftLoader)  
	: UIActivityIndicator 대용으로 사용한다.
- [Quick (tag: v0.9.0)](https://github.com/Quick/Quick/tree/v0.9.0)  
	: BDD framework for swift
- [Nimble (tag: v.3.2.1)](https://github.com/TaemoonCho/Nimble/tree/v3.2.1)  
	: Cedar 스타일의 matcher를 제공한다.

## How to Build (on OSX)
[CocoaPods](http://cocoapods.org)을 통해 의존성을 관리함으로 CocoaPods를 설치  
```bash
$ gem install cocoapods
```  

설치가 끝나면 ProjectRootDiretory에서  
```bash
$ pod install
```
  
문제가 있을 경우 마찬가지로 ProjectRootDiretory에서 podforceupdate.sh 실행.  
```bash
$ ./podforceupdate.sh
```


> **podforceupdate.sh**
>
> Cocoapods cache 및 build를 모두 지우고 새롭게 받으며 Xcode workspace file로 지우고 새로 생성하는 bash 쉘 스크립트.


## Report about running
* 발견한 Crash 없음.
* 30분 이상 테스트에도 50mb 이하의 메모리 사용.
* 평균 30개 정도의 Feed와 각 이미지들을 메모리에 적재하고 있음.
* 너무 빠른 시간을 설정할 경우 flickr 공개 피드가 중복된 feed를 반환할 수 있음.