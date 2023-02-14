import UIKit

// UIStoryboardSegue 클래스를 서브클래싱하여 새로운 기능을 갖춘 커스텀 세그웨이를 만들어준다.
class NewSegue: UIStoryboardSegue {
    
    // UIStoryboardSegue에서 세그웨이의 실행을 처리하는 메소드 오버라이드
    override func perform() {
        // 세그웨이의 출발지 뷰 컨트롤러
        let srcUVC = self.source
        // 세그웨이의 목적지 뷰 컨트롤러
        let destUVC = self.destination
        
        // fromView에서 toView로 뷰를 전환한다.
        UIView.transition(from: srcUVC.view,
                          to: destUVC.view,
                          duration: 1,
                          options: .transitionCurlDown)
        /*
            화면 전환 시 뷰 컨트롤러 전체를 전환하지 않고, 다른 컨트롤러에 있는 뷰만 읽어와 전환하는 세그웨이이다.
            이를 응용하면 뷰 컨트롤러 하나에서 상태값에 따라 여러 가지 다른 뷰를 다양하게 표현하는 것이 가능하다.
            좋은 구조는 아님. 가급적이면 1뷰컨트롤러-1루트뷰 로 하자
        */
    }
}
