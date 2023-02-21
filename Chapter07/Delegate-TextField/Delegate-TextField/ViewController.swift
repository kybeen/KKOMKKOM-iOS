//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by 김영빈 on 2023/02/21.
//

import UIKit

// 델리게이트 패턴 적용을 위해 UITextFieldDelegate 프로토콜 구현 선언
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* 텍스트 필드 속성 설정 */
        self.tf.placeholder = "값을 입력하세요"
        self.tf.keyboardType = UIKeyboardType.alphabet // 키보드 타입 영문자 패드로
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark // 키보드 스타일 어둡게
        self.tf.returnKeyType = UIReturnKeyType.join // 리턴키 타입 "Join"
        self.tf.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 "On" --> 값이 입력되지 않으면 리턴키 비활성화
        
        /* 스타일 설정 */
        // 테두리 스타일 - 직선
        self.tf.borderStyle = UITextField.BorderStyle.line // 테두리 - 직선
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0) // 배경 색상
        self.tf.contentVerticalAlignment = .center // 텍스트가 수직 방향으로 가운데 정렬
        self.tf.contentHorizontalAlignment = .center // 텍스트가 수평 방향으로 가운데 정렬
        self.tf.layer.borderColor = UIColor.darkGray.cgColor // 테두리 색상을 회색으로 (텍스트 필드 테두리 색상은 UIColor보다 저수준에서 구현된 CGColor 타입의 값을 사용하기 때문에 CGColor 타입으로 변환해준다.)
        self.tf.layer.borderWidth = 2.0 // 테두리 두께 설정 (단위 : pt)
        
        /* 텍스트 필드를 최초 응답자로 지정 */
        // 앱이 열리면 자동으로 키보드가 나타남
        self.tf.becomeFirstResponder()
        
        
        /* 델리게이트 지정 */
        // delegate 속성 : 텍스트 필드에 특정 이벤트가 발생했을 때 알려줄 대상 객체를 가리키는 속성
        // self : 현재 뷰 컨트롤러의 인스턴스
        // 텍스트 필드에서 미리 정해진 특정 이벤트가 발생하면 현재의 뷰 컨트롤러에게 알려주기 ==> 뷰 컨트롤러가 텍스트 필드의 델리게이트 객체로 지정됨
        self.tf.delegate = self
    }
    
    @IBAction func confirm(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체로 지정
        self.tf.becomeFirstResponder()
    }
    
}

