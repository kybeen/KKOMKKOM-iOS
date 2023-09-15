//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by 김영빈 on 2023/02/16.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - 아울렛 변수
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    // MARK: - 직접 전달 방식 사용
//    // 값을 직접 전달받을 프로퍼티들
//    var paramEmail: String?
//    var paramUpdate: Bool?
//    var paramInterval: Double?
//
//    /*
//     인스턴스를 새로 만드는 것이 아니라 이미 만들어진 인스턴스로 화면이 전환되는 것이기 때문에 viewDidLoad()가 아니라
//     뷰 컨트롤러의 뷰가 화면에 표시될 때마다 실행되는 메소드인 viewWillAppear(_:)를 오버라이드 해준다.
//     */
//    override func viewWillAppear(_ animated: Bool) {
//        // 옵셔널 바인딩으로 값 체크 (nil값 시에는 아무것도 변경하지 X)
//        if let email = paramEmail {
//            resultEmail.text = email
//        }
//        if let update = paramUpdate {
//            resultUpdate.text = update==true ? "자동갱신" : "자동갱신안함"
//        }
//        if let interval = paramInterval {
//            resultInterval.text = "\(Int(interval))분마다"
//        }
//    }
    
    
    // MARK: - 간접 전달 방식 (AppDelegate 사용)
//    override func viewWillAppear(_ animated: Bool) {
//        // AppDelegate.swift의 AppDelegate 객체의 인스턴스를 갖고온다.
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        if let email = ad?.paramEmail {
//            resultEmail.text = email
//        }
//        if let update = ad?.paramUpdate {
//            resultUpdate.text = update==true ? "자동갱신" : "자동갱신안함"
//        }
//        if let interval = ad?.paramInterval {
//            resultInterval.text = "\(Int(interval))분마다"
//        }
//    }
    
    
    // MARK: - 간접 전달 방식 (UserDefaults 사용)
    override func viewWillAppear(_ animated: Bool) {
        // UserDefaults 객체의 인스턴스를 갖고온다.
        let ud = UserDefaults.standard
        
        // 저장된 값을 꺼낼 때에는 저장된 값의 타입에 맞는 메소드를 사용하면 캐스팅 과정 없이 바로 사용 가능
        // UserDefaults 객체에서 값을 읽어오는 메소드 중 String 타입만 반환값이 옵셔널 타입이기 때문에 옵셔널 바인딩 필요
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdate.text = (update==true ? "자동갱신" : "자동갱신안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분마다"
    }
}

