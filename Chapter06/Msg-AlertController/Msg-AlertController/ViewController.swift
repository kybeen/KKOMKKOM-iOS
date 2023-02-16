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
    }

    @IBOutlet var result: UILabel!
    
    @IBAction func alert(_ sender: Any) {
        // 메시지창 객체 생성
        let alert = UIAlertController(title: "선택",
                                      message: "항목을 선택해주세요",
                                      preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소",
                                   style: UIAlertAction.Style.cancel)
        let ok = UIAlertAction(title: "확인",
                               style: UIAlertAction.Style.default)
        let exec = UIAlertAction(title: "실행",
                                 style: UIAlertAction.Style.destructive)
        let stop = UIAlertAction(title: "중지", style: UIAlertAction.Style.default)
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        // 메시지 창 실행
        self.present(alert, animated: true)
    }
}

