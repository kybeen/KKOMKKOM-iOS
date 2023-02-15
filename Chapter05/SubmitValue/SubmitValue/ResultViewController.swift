import UIKit

// 값 전달받은 화면 뷰 컨트롤러
class ResultViewController: UIViewController {
    // [ 아울렛 변수 ]
    @IBOutlet var resultEmail: UILabel! // 이메일
    @IBOutlet var resultUpdate: UILabel! // 자동갱신 여부
    @IBOutlet var resultInterval: UILabel! // 갱신주기
    
    // [ 이전 화면으로부터 값을 대입받을 프로퍼티 ]
    // 아울렛 변수는 외부에서 값을 직접 대입할 수 없는 변수이고, 외부 객체에서 직접 참고할 수 없기 때문에 값을 대입받을 프로퍼티를 별도로 만들어 주어야 한다.
    var paramEmail: String = ""
    var paramUpdate: Bool = false
    var paramInterval: Double = 0
    
    // 화면이 메모리에 로드되고 난 직후의 시점에 화면에 값을 표시해준다.
    override func viewDidLoad() {
        self.resultEmail.text = paramEmail
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신안함")
        self.resultInterval.text = "\(Int(paramInterval))분 마다 갱신"
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
