# Chapter 06 사용자에게 메시지를 전달하는 방법 - 로컬 알림
**로컬 알림**은 앱 내부에서 만든 특정 메세지를 iOS의 알림 센터를 통해 전달하는 방법으로, 앱이 종료되어 있거나 백그라운드 상태일 때 메세지를 전달할 수 있는 대표적인 방법 중 하나이다.

----
- **UserNotification** : iOS 10 버전부터 추가된 사용자 알림에 관한 모든 것을 처리해주는 프레임워크 ( import UserNotifications )
- **UILocalNotification** : UserNotification 이전에 로컬 알림을 위해 사용되던 UIKit에 정의된 객체


----
## [ UserNotification ]
**[ UserNotification 프레임워크 주요 객체 ]**
- **UNMutableNotificationContent** : 알림 콘텐츠에 대한 설정 가능 (내용, 효과 등)
- **UNTimeIntervalNotificationTrigger** : 알림 발송 조건 관리 (발생 시각, 반복 여부 등)
- **UNNotificationRequest** : 알림 요청 객체 (알림 콘텐츠 객체와 알림 발송 조건 객체를 인자값으로 주어 객체 생성)
- **UNUserNotificationCenter** : 알림의 실제 발송을 담당

UserNotification 프레임워크에서는 로컬/푸시 알림을 사용하기 위해 UNUserNotificationCenter 객체를 이용하여 미리 알림 설정 환경을 정의하고, 설정 내용을 사용자에게 승인 받는 과정을 거쳐야 한다.

이 동의 과정은 앱이 처음 실행될 때 받는 것이 자연스럽기 때문에 코드는 보통 앱 델리게이트의 application() 메소드 내부에 작성해준다.

로컬 알림을 보내는 내용은 앱이 백그라운드 상태일 때 호출되는 메소드인 ~~applicationWillResignActive()~~에 작성해준다.

==> **iOS 13 이후 변경된 생명주기 이벤트 전달 방식에 의해서 이제는 SceneDelegate.swift의 sceneWillResignActive(_:)이다.**

**[ 실습 프로세스 ]**
1. 사용자 동의 확인 받기
2. 사용자로부터 알림이 허용되어 있는지 체크
3. UNMutableNotificationContent 클래스를 사용하여 알림 콘텐츠 객체 생성
4. 알림 콘텐츠 객체 내용 설정
5. UNTimeIntervalNotificationTrigger 클래스를 초기화하여 알림 발송 조건을 지정한 객체를 생성
6. UNNotificationRequest 클래스를 초기화하여 알림 요청 객체를 생성
7. 생성된 알림 요청 객체를 노티피케이션 센터에 추가


----
- **UNUserNotificationCenter.requestAuthorization()** : 사용자에게 알림 설정에 대한 동의 받기
    - 1번째 인자값 : 알림 메세지에 포함될 항목 (배열)
    - 2번째 인자값 : 메세지 창의 버튼을 눌렀을 때 실행되는 클로저 (알림 동의 여부 / 오류 발생 시 오류 객체 타입 2개의 매개변수로 구성됨)

----
### [ 받은 알림 처리하기 ]
델리게이트 패턴 구조를 사용하여 받은 알림에 대해 처리해줄 수 있다.
1. AppDelegate 클래스에 UNUserNotificationCenterDelegate 프로토콜을 추가해준다.
2. userNotificationCenter 메소드를 구현해준다.
    - userNotificationCenter(_:willPresent:withCompletionHandler:) : 앱 실행 중 알림 메세지 도착할 경우 호출
    - userNotificationCenter(_:didReceive:withCompletionHandler:) : 사용자가 알림 메시지를 실제로 클릭 시 호출






----
## [ UILocalNotification 객체를 이용한 로컬 알림 ]
- **UIApplication.shared** : UIApplication 객체는 싱글턴 패턴으로 설계되어 있기 때문에 참조하고 싶다면UIApplication.shared 로 접근해준다.
    - **.registerUserNotificationSettings(_:)** : 알림 허용 여부를 사용자에게 확인받고, 사용자의 선택을 애플리케이션에 등록
    - **.currentUserNotificationSettings** : 현재 설정된 알림 허용 여부 정보를 읽어옴
    - **.scheduleLocalNotification(_:)** : 생성된 알림 객체를 iOS의 스케줄러에 등록한다. 등록된 알림 객체는 fireDate 속성에 설정된 시간에 맞게 발송된다.
    - **.presentLocalNotificationNow(_:)** : 생성된 알림 객체의 fireDate 속성을 무시하고, 즉각 발송함