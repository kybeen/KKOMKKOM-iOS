//
//  ViewController.swift
//  Msg-AlertController
//
//  Created by 김영빈 on 2023/02/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 아직 뷰가 화면에 구현되기 전이기 때문에 메세시 창을 처리하기 부적절함
    }
    override func viewDidAppear(_ animated: Bool) {
        // 뷰가 화면에 구현된 상태이기 때문에 메세지 창을 처리하기 적절한 위치임
        let netAlert = UIAlertController(title: "네트워크 연결 실패", message: "네트워크에 연결되지 않았습니다.", preferredStyle: UIAlertController.Style.alert)
        let netOk = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        netAlert.addAction(netOk)
        self.present(netAlert, animated: true)
    }
    

    @IBOutlet var result: UILabel!
    
    // 알림창 실행 액션 메소드
    @IBAction func alert(_ sender: Any) {
        // 메시지창 객체 생성
        let alert = UIAlertController(title: "선택",
                                      message: "항목을 선택해주세요",
                                      preferredStyle: UIAlertController.Style.alert)
        // 버튼 객체 생성
        let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel) { (_) in // 취소 버튼
            self.result.text = "취소 버튼을 클릭했습니다."
        }
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (_) in // 확인 버튼
            self.result.text = "확인 버튼을 클릭했습니다."
        }
        let exec = UIAlertAction(title: "실행", style: UIAlertAction.Style.destructive) { (_) in // 실행 버튼
            self.result.text = "실행 버튼을 클릭했습니다."
        }
        let stop = UIAlertAction(title: "중지", style: UIAlertAction.Style.default) { (_) in // 중지 버튼
            self.result.text = "중지 버튼을 클릭했습니다."
        }
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        // 메시지 창 실행
        self.present(alert, animated: true)
    }
    
    // 로그인 버튼 액션 메소드
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID를 입력하십시오."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (_) in
            // 확인 버튼을 클릭했을 떄 처리할 내용
            if let tf = alert.textFields?[0] { // textFields[0] : 1번째 텍스트필드
                print("입력된 값은 \(tf.text!)입니다.")
            } else {
                print("입력된 값이 없습니다.")
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 텍스트 필드 추가
        alert.addTextField()
        alert.addTextField(configurationHandler: { (tf) in
            // 텍스트필드의 속성을 설정하기 위한 클로저 인자
            tf.placeholder = "암호" // 안내 메세지
            tf.isSecureTextEntry = true // 비밀번호 가리기
        })
        
        self.present(alert, animated: true)
    }
    
    // 사용자 인증 버튼 액션 메소드
    @IBAction func auth(_ sender: Any) {
        // 메세지 창 정의
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (_) in
            // 확인 버튼을 클릭했을 때 실행할 내용
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text
            
            if loginId == "sqlpro" && loginPw == "1234" {
                self.result.text = "인증되었습니다."
            } else {
                self.result.text = "인증에 실패하였습니다."
            }
        }
        
        // 메세지 창에 버튼 추가
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 아이디 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "아이디"
            tf.isSecureTextEntry = false
        })
        // 비밀번호 필드 추가
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "비밀번호"
            tf.isSecureTextEntry = true
        })
        
        self.present(alert, animated: true)
    }
    
}

