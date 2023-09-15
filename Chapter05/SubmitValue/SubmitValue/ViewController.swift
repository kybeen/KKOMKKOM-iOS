//
//  ViewController.swift
//  SubmitValue
//
//  Created by 김영빈 on 2023/02/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // [ 아울렛 변수 ]
    @IBOutlet var email: UITextField! // 이메일 주소 입력 텍스트 필드
    @IBOutlet var isUpdate: UISwitch! // 자동갱신 여부 스위치
    @IBOutlet var interval: UIStepper! // 갱신주기 스테퍼
    
    @IBOutlet var isUpdateText: UILabel! // 자동갱신 여부 표시 레이블
    @IBOutlet var intervalText: UILabel! // 갱신주기 표시 레이블
    
    // [ 액션 메소드 ] - 액션 메소드를 호출한 컨트롤의 속성값이 필요한 경우에는 인자로 Any가 아닌 개별 타입을 선택해준다.
    // 자동 갱신 여부가 바뀔 때 호출
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.isUpdateText.text = "갱신함"
        } else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    
    // 갱신주기가 바뀔 때 호출
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value) // 스테퍼의 값은 기본적으로 실수 자료형이기 때문에 표시할 레이블의 텍스트에는 정수로 바꿔준다.
        self.intervalText.text = "\(value)분 마다"
    }
    
    // -------------- [ Submit 버튼 클릭 시 호출 1 ] --------------
    @IBAction func onSubmit(_ sender: Any) {
        // VC2의 인스턴스 생성 - 화면 전환 뿐만 아니라 전환할 뷰 컨트롤러의 프로퍼티를 참조하고 값을 대입해야 하기 때문에 UIViewController를 ResultViewController 클래스로 타입 캐스팅을 해주어야 한다.
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
            return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text! // 이메일 (paramEmail이 일반 문자열 타입이기 때문에 옵셔널을 강제로 해제해준다.)
        rvc.paramUpdate = self.isUpdate.isOn // 자동갱신 여부
        rvc.paramInterval = self.interval.value // 갱신주기
        
        // 화면 이동
//        self.present(rvc, animated: true) // 프레젠테이션 방식
        self.navigationController?.pushViewController(rvc, animated: true) // 내비게이션 방식
    }
    
    // -------------- [ Submit 버튼 클릭 시 호출 2 - 매뉴얼 세그웨이 사용 시 ] --------------
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self)
    }
    // 세그웨이가 실행되기 전에 호출되는 prepare 메소드를 오버라이드하여 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 목적지 뷰 컨트롤러 인스턴스 읽어오기
        let dest = segue.destination
        guard let rvc = dest as? ResultViewController else {
            return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
    }
}
