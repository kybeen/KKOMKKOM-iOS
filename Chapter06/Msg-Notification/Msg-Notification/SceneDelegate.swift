//
//  SceneDelegate.swift
//  Msg-Notification
//
//  Created by 김영빈 on 2023/02/18.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    // MARK: - 앱이 활성화 상태를 잃었을 때 실행되는 메소드
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        // MARK: - 플랫폼 버전에 따라 실행 로직을 구분해준다. (iOS 9까지는 UILocalNotification 객체 / iOS 10 이상부터는 UserNotification 프레임워크)
        /* --------------- UserNotifications 사용하는 경우 (iOS 10.0 이상) --------------- */
        if #available(iOS 10.0, *) { // UserNotification 프레임워크를 이용한 로컬 알림 (iOS 10 이상)
            // 사용자의 알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized { // 동의했다면
                    // 알림 콘텐츠 객체 생성 및 발송할 내용 정의
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1 // 앱 아이콘에 표시될 값 (확인하지 않은 알림 개수 표시)
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요 !!" // UILocalNotification에서는 지원 X
                    nContent.body = "앗! 왜 나갔어요??? 어서 들어오세요!!"
                    nContent.sound = UNNotificationSound.default // 알림 효과음 설정
                    nContent.userInfo = ["name": "홍길동"] // 로컬 알림과 함께 전달하고 싶은 값이 있을 때 사용하는 속성 (화면에는 표시되지 않지만 알림을 눌러서 연결되는 앱 델리게이트 메소드에서는 참조할 수 있다.)
                    
                    // 알림 발송 시간 설정 - 앱 비활성화 시 5초 후 자동 발송
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    // 알림 요청 객체
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    
                    // 알림 요청 객체를 노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request)
                    
                } else { // 동의하지 않았다면
                    print("사용자가 동의하지 않음!!!")
                }
            }
        }
        /* --------------- UILocalNotification 사용하는 경우 (iOS 10.0 미만) --------------- */
        else { // UILocalNotification 객체를 이용한 로컬 알림
            // 알림 설정 확인
            let setting = UIApplication.shared.currentUserNotificationSettings
            
            // 알림 설정이 되어 있지 않다면 로컬 알림을 보내도 받을 수 없으므로 종료함
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }
            
            // 로컬 알림 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10) // 10초 후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent // 현재 위치에 따라 타임존 설정
            noti.alertBody = "얼른 다시 접속하세요!!!" // 표시될 메세지
            noti.alertAction = "학습하기" // 잠금 상태일 때 표시될 액션 ("밀어서 학습하기")
            noti.applicationIconBadgeNumber = 1 // 앱 아이콘 모서리에 표시될 배지
            noti.soundName = UILocalNotificationDefaultSoundName // 로컬 알람 도착 시 사운드
            noti.userInfo = ["name": "홍길동"] // 알람 실행 시 함께 전달하고 싶은 값. (화면에는 표시되지 X)
            
            // 생성된 알람 객체를 스케줄러에 등록
            UIApplication.shared.scheduleLocalNotification(noti)
            
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

