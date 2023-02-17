# Chapter 06 사용자에게 메시지를 전달하는 방법 - 로컬 알림
**로컬 알림**은 앱 내부에서 만든 특정 메세지를 iOS의 알림 센터를 통해 전달하는 방법으로, 앱이 종료되어 있거나 백그라운드 상태일 때 메세지를 전달할 수 있는 대표적인 방법 중 하나이다.

----
- **UserNotification** : iOS 10 버전부터 추가된 사용자 알림에 관한 모든 것을 처리해주는 프레임워크 ( import UserNotifications )
- **UILocalNotification** : UserNotification 이전에 로컬 알림을 위해 사용되던 UIKit에 정의된 객체


----
### [ UserNotification 프레임워크 주요 객체 ]
- **UNMutableNotificationContent** : 알림 콘텐츠에 대한 설정 가능 (내용, 효과 등)
- **UNTimeIntervalNotificationTrigger** : 알림 발송 조건 관리 (발생 시각, 반복 여부 등)
- **UNNotificationRequest** : 알림 요청 객체 (알림 콘텐츠 객체와 알림 발송 조건 객체를 인자값으로 주어 객체 생성)
- **UNUserNotificationCenter** : 알림의 실제 발송을 담당