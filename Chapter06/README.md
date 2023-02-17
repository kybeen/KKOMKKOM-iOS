# Chapter 06 사용자에게 메시지를 전달하는 방법
- **Msg-AlertController : 메시지 창 실습**
- **Msg-Notification : 로컬 알림**

----
## 앱 내에서 사용자에게 메시지를 전달하는 대표적인 방법
### 1. 메시지 창(알림창)
  - 앱이 실행 중일 때만 동작
### 2. 로컬 푸시
  - 앱 내부에서 특정 프로세스에 의해 등록된 메시지를 iOS가 전달되는 방식
### 3. 서버 푸시
  - 별도의 서버를 통해 APNs(Apple Push Notification Service)라는 애플 고유의 메시징 시스템에게 보낸 메시지가 네트워크를 통해 전달되는 방식

----
## [ 메시지 창 구현 방법 ]
1. UIAlertController 클래스의 인스턴스 생성
2. UIAlertAction 버튼 객체 생성
3. UIAlertAction 버튼 클래스의 인스턴스를 UIAlertController 인스턴스에 등록 ( addAction() )
4. 메시지 창 인스턴스를 실행해서 화면에 출력 ( present() )

- **UIAlertController** : 메시지 알림창
  - 알림창, 액션 시트 2가지 형태로 제공
- **UIAlertAction** : 버튼

----
## [ 로컬 알림(로컬 푸시) ]
- **UserNotification** : iOS 10 버전부터 추가된 사용자 알림에 관한 모든 것을 처리해주는 프레임워크 ( import UserNotifications )
- **UILocalNotification** : UserNotification 이전에 로컬 알림을 위해 사용되던 UIKit에 정의된 객체