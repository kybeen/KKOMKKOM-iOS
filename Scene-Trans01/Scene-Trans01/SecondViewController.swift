import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        // dissmiss()의 애니메이션 효과는 present()로 등장했을 때와 같은 효과를 반대로
        self.presentingViewController?.dismiss(animated: true)
    }
}
