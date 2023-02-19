//
//  ViewController.swift
//  Msg-Notification
//
//  Created by 김영빈 on 2023/02/18.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var msg: UITextField!
    @IBOutlet var datepicker: UIDatePicker!
    
    @IBAction func save(_ sender: Any) {
        if #available(iOS 10, *) {
            /* ---------- UserNotifications 프레임워크를 사용한 로컬 알림 ---------- */
            // 알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    DispatchQueue.main.async { // 백그라운드에서 실행되는 로직을 메인 쓰레드에서 실행되도록 처리해줌
                        // 알림 콘텐츠 정의
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        nContent.title = "미리 알림"
                        nContent.sound = UNNotificationSound.default
                        
                        // 발송 시각을 '지금으로부터 *초 형식'으로 변환
                        let time = self.datepicker.date.timeIntervalSinceNow
                        // 발송 조건 정의
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        // 발송 요청 객체 정의
                        let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                        
                        // 노티피케이션 센터에 추가
                        // add(_:) 메소드의 두번째 인자값으로 완료 시 호출될 클로저를 입력해 줄 수 있다.
                        UNUserNotificationCenter.current().add(request) { (_) in // 후행 클로저 형식으로 메세지 창 호출 코드 작성
                            DispatchQueue.main.async {
                                // 발송 완료 안내 메세지 창
                                let date = self.datepicker.date.addingTimeInterval(9*60*60) // 우리나라 시간으로 보여주기 위해 세계 표준시에서 9시간을 더해줌
                                let message = "알림이 등록되었습니다. 등록된 알림은 \(date)에 발송됩니다."
                                
                                let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default)
                                alert.addAction(ok)
                                self.present(alert, animated: true)
                            }
                        }
                        
                        
                    }
                } else {
                    let alert = UIAlertController(title: "알림 등록", message: "알림이 허용되어 있지 않습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: true)
                    return
                }
            }
        } else {
            /* ---------- LocalNotification 객체를 사용한 로컬 알림 ---------- */
        }
    }
}

