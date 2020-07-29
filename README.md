# App Store Search
[![Language](https://img.shields.io/badge/swift-5-orange.svg)](https://swift.org)
[![IDE](https://img.shields.io/badge/Xcode-11-blue.svg)](https://developer.apple.com/xcode/)
[![Platform](https://img.shields.io/badge/iOS-10~13-yellow.svg)](https://developer.apple.com/ios/)
[![Device](https://img.shields.io/badge/device-iPhone,iPad-green.svg)](https://developer.apple.com/)

> ### [iOS]  App Store 검색 탭 구현 

## 개발 환경
- Interface
    - Storyboard(xib)
    - Autolayout
- CocoaPods 
    - ★  평점  ([cosmos](https://cocoapods.org/pods/Cosmos "cosmos"))
- Api
    - [itunes Search API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api "api link")

## 기능
- 최근 검색어 로컬 관리
- 최근 검색어 필터 기능
- 앱스토어 검색 api 연동
- 검색 목록 및 상세 화면 구현
- 다크 모드 지원


## 프로젝트 설정
1. **Clone** the repo and install the dependencies.
    ``` sh
        # Project clone (Cocoapod included)
        git clone https://github.com/mkyung0825/app_store_search.git 
    ```
2. **Open** AppStoreSearch.xcworkspace
3. **Run Project** 
    - Xcode > Product > Run  **(⌘ +  R)**
    

## 디렉토리 구조
```
.
├── api 
│   ├── ApiResponse.swift               # 공통 Api Response (success, fail) 
│   ├── ApiRequestManager.swift         # Api 호출 함수 목록 정의
│   └── NetworkManager.swift            # 공통 Api 호출 프로세스
├── common                              
│   ├── Common.swift                    # 공통 함수들 정의
│   ├── ExtensionManager.swift          # view 확장 파일
│   └── UserDefaultManager.swift        # 로컬 데이터 관리
├── model                               
│   └── Result.swift                    # Rsult 모델
├── view                               
│   └── search                          # 검색 관련 뷰
│       └── cell                        # 검색 > 테이블뷰 셀
│           ├── list                    # 검색 > 테이블뷰 셀 > 목록
│           └── detail                  # 검색 > 테이블뷰 셀 > 상세
├── controller                          
│   ├── main/                           # 메인 화면 (메인 탭)
│   └── search/                         # 검색 화면 (목록, 상세)
├── Info.plist                          # 프로젝트 설정
├── Assets.xcassets                     # 이미지 리소스
├── Base.lproj                          # 스토리보드 (메인, 런치스크린)
├── SceneDelegate.swift                 # Scene 생명주기 관리 (>iOS 13)
└── AppDelegate.swift                   # App 생명주기 관리 
```


## 미리보기
##### iPhone
<img width="30%" alt="iphone_1" src="https://user-images.githubusercontent.com/68898743/88765442-732d8100-d1b1-11ea-9ca0-aeffa494c2f6.png"></img>
<img width="30%" alt="iphone_2" src="https://user-images.githubusercontent.com/68898743/88765440-7294ea80-d1b1-11ea-9328-46480e71c203.png"></img>
<img width="30%" alt="iphone_3" src="https://user-images.githubusercontent.com/68898743/88765436-7163bd80-d1b1-11ea-8f71-23933c48cf73.png"></img>
<img width="30%" alt="iphone_4" src="https://user-images.githubusercontent.com/68898743/88765439-71fc5400-d1b1-11ea-919a-43918c97269c.png"></img>
<img width="30%" alt="iphone_5" src="https://user-images.githubusercontent.com/68898743/88765433-70329080-d1b1-11ea-8e1f-5d8813a1bd98.png"></img>
<img width="30%" alt="iphone_6" src="https://user-images.githubusercontent.com/68898743/88765425-6c067300-d1b1-11ea-8420-ea66e47fef4c.png"></img>

##### iPad
<img width="30%" alt="ipad_1" src="https://user-images.githubusercontent.com/68898743/88765311-424d4c00-d1b1-11ea-8dd0-81e1dc74bf9b.png"></img>
<img width="30%" alt="ipad_2" src="https://user-images.githubusercontent.com/68898743/88765332-4a0cf080-d1b1-11ea-96ae-e3468aa1b48a.png"></img>
<img width="30%" alt="ipad_3" src="https://user-images.githubusercontent.com/68898743/88765331-49745a00-d1b1-11ea-91ee-ba46e14a3fde.png"></img>
<img width="30%" alt="ipad_4" src="https://user-images.githubusercontent.com/68898743/88765328-48432d00-d1b1-11ea-8d09-4f44b72427f9.png"></img>
<img width="30%" alt="ipad_5" src="https://user-images.githubusercontent.com/68898743/88765324-47aa9680-d1b1-11ea-84dc-7c6da3f5ffbe.png"></img>
<img width="30%" alt="ipad_6" src="https://user-images.githubusercontent.com/68898743/88765321-46796980-d1b1-11ea-8808-22563e4bd901.png"></img>
