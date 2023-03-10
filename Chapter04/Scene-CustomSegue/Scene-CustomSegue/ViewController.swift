//
//  ViewController.swift
//  Scene-CustomSegue
//
//  Created by 김영빈 on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 전처리 메소드 작성
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Xcode 디버그 콘솔에 로그 출력
        NSLog("Segueway identifier : \(segue.identifier!)")
        
        if (segue.identifier == "custom_segue") {
            NSLog("커스텀 세그가 실행됩니다.")
            // 커스텀 세그가 실행될 때 처리할 내용을 여기에 작성
        } else if (segue.identifier == "action_segue") {
            NSLog("액션 세그가 실행됩니다.")
            // 액션 세그가 실행될 때 처리할 내용을 여기에 작성
        } else {
            NSLog("알 수 없는 세그입니다.")
            // 기타 세그웨이가 실행될 때 처리할 내용을 여기에 작성
        }
    }

}

