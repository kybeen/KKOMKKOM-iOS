import UIKit

class FormViewController: UIViewController {
    // [ 아울렛 변수 ]
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBOutlet var updateLabel: UILabel!
    @IBOutlet var intervalLabel: UILabel!
    
    // [ 액션 메소드 ]
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.updateLabel.text = "자동갱신"
        } else {
            self.updateLabel.text = "자동갱신안함"
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        self.intervalLabel.text = "\(Int(sender.value))분마다"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        /* 직접 전달 방식 사용 */
//        // @@@ presentingViewController 속성을 통해 이전 화면 객체를 읽어온 다음, ViewController 타입(이전 화면 뷰 컨트롤러)으로 캐스팅 @@@
//        let preVC = self.presentingViewController
//        guard let vc = preVC as? ViewController else {
//            return
//        }
//
//        // 값 전달
//        vc.paramEmail = self.email.text
//        vc.paramUpdate = self.isUpdate.isOn
//        vc.paramInterval = self.interval.value
//
//        // 이전 화면으로 복귀
//        self.presentingViewController?.dismiss(animated: true)
        
        
        /* 간접 전달 방식 (AppDelegate 사용) */
//        // AppDelegate.swift의 AppDelegate 객체의 인스턴스를 갖고온다.
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        // 값 저장
//        ad?.paramEmail = self.email.text
//        ad?.paramUpdate = self.isUpdate.isOn
//        ad?.paramInterval = self.interval.value
//
//        // 이전 화면으로 복귀
//        self.presentingViewController?.dismiss(animated: true)
        
        
        /* 간접 전달 방식 (UserDefaults 사용) */
        // UserDefault 객체의 인스턴스를 가져온다.
        let ud = UserDefaults.standard
        
        // 값 저장
        ud.set(self.email.text, forKey: "email")
        ud.set(self.isUpdate.isOn, forKey: "isUpdate")
        ud.set(self.interval.value, forKey: "interval")
        
        // 이전 화면으로 복귀
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
