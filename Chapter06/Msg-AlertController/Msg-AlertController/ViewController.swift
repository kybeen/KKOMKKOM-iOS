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
}

