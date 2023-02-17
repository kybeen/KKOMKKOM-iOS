//
//  AppDelegate.swift
//  Msg-Notification
//
//  Created by 김영빈 on 2023/02/18.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    /* 앱이 처음 실행될 때 호출되는 메소드 */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /* 실습 코드 작성 */
        if #available(iOS 10.0, *) {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 사용자 동의 여부 창을 실행
            // UNUserNotificationCenter 객체는 싱글톤 패턴으로 정의되어 있기 때문에 인스턴스 객체를 만들지 않고, UNUserNotificationCenter.current() 로 시스템 제공 인스턴스를 받아온다.
            let notiCenter = UNUserNotificationCenter.current()
            // 1번째 인자값 : [ 알림창, 아이콘 배지, 알림소리 ]에 대한 알림 설정 내용 동의를 받는다.
            // 2번째 인자값 : didAllow(알림 동의 여부) / e(오류 객체 타입)
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) {(didAllow, e) in
                print("권한 동의 여부 : \(didAllow)")
            }
            notiCenter.delegate = self // 알림 센터와 관련하여 발생하는 이벤트를 앱 델리게이트 클래스가 감지하도록 설정
            
        } else {
            
        }
        
        return true
    }
    
    // 앱이 백그라운드 상태일 때 실행되는 메소드 --> XXXXX
    // iOS 13 버전부터는 SceneDelegate.swift의 sceneWillResignActive() 메소드임
//    func applicationWillResignActive(_ application: UIApplication) {
//
//    }
    
    /* 앱 실행 도중에 알림 메세지가 도착한 경우 */
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "wakeup" {
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        // 알림 배너 띄워주기
        completionHandler([.alert, .badge, .sound])
    }
    
    /* 사용자가 알림 메세지를 클릭했을 경우 */
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler()
    }
    
    
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

