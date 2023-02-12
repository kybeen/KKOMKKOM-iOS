//
//  ViewController.swift
//  Scene-Trans01
//
//  Created by 김영빈 on 2023/02/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveNext(_ sender: Any) {
        // 이동할 뷰 컨트롤러 객체를 StoryBoard ID 정보를 이용하여 참조. (스토리보드 객체가 참조될 때의 타입은 UIStoryboard)
        // 현재 Main.storyboard 파일이 기본 스토리보드 파일로 지정되어 있기 때문에 self.storyboard로 Main.storyboard 파일이 참조 가능하다.
        // instantiateViewController(withIdentifier:) 메소드는 인자값으로 받은 아이디로 스토리보드에서 뷰 컨트롤러를 찾고, 연결된 클래스를 읽어와 뷰 컨트롤러에 대한 인스턴스를 생성한다.

        
// 1. 옵셔널 바인딩을 거치지 않는 구문
//         // self.storyboard의 타입은 옵셔널인데 nil 검사 없이 바로 갖고오는 것은 오류 발생 가능
//         let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC")
//
//
//
//        /*
//         [ 화면 전환할 때의 애니메이션 타입 ]
//
//         coverVertical : 아래에서 위로 (디폴트)
//         crossDissolve : 두 화면이 교차
//         flipHorizontal : 화면 중앙 가상의 축을 기준으로 화면이 돌아가는 효과
//         partialCurl : 화면 오른쪽 아래 모서리에서 페이지가 말려 올라가는 효과
//         */
//        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//
//        // 인자값으로 뷰 컨트롤러 인스턴스를 넣고 프레젠트 메소드 호출
//        self.present(uvc, animated: true)
        
        
// // 2. 옵셔널 바인딩을 거치는 더 안전한 구문
//        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
//            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//            self.present(uvc, animated: true)
//        }
        
        
// 3. guard 조건문으로 필터링하는 구문
        // 이동할 뷰 컨트롤러 객체를 StoryboardID 정보를 이용하여 참조.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        self.present(uvc, animated: true)
    }
}

