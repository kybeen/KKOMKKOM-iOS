import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func back2(_ sender: Any) {
        /*
         지금은 안나오는데 책에서는(이전 버전에서는) UIViewController? 타입의 값을 반환하는데 왜 받아주지 않냐는 경고 메세지가 나온다.
         이럴 경우 언더바를 사용해서 익명 변수 처리를 해준다.
         (값을 대입할 변수가 필요한 것은 알지만 사용하진 않을 것이니 굳이 변수에 값을 할당하지 않겠다고 컴파일러에 알려줌)
        */
        _ = self.navigationController?.popViewController(animated: true)
    }
}
