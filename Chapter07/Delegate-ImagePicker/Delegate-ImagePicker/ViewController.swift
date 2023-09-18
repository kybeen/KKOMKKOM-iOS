//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by 김영빈 on 2023/02/24.
//

import UIKit

/* ---------- 익스텐션을 사용한 코드 --> 프로토콜 별 정의된 메소드를 깔끔하게 정리할 수 있다. ---------- */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var imgView: UIImageView!
    
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 가능 On
        picker.delegate = self // 델리게이트 지정
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: true)
    }
}

// MARK: - 델리게이트 관련 내용은 익스텐션으로 따로 구분
extension ViewController: UIImagePickerControllerDelegate {
    // MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 창 닫기
        // 내부적으로 알아서 self.presentingViewController 쪽으로 연결시켜 주기 때문에 self.dismiss()로 안해도 됨
        picker.dismiss(animated: false) { () in
            // 이미지 피커 컨트롤러가 완전히 닫히고 나서 로직이 실행되도록 하기 위해 dismiss(animated:complete:) 메소드 사용
            // 알림창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage // info에 편집된 이미지에 대한 관련 키를 넣어서 편집된 이미지 정보를 추출
            self.imgView.image = img
        }
    }
}
// MARK:- 내비게이션 컨트롤러 델리게이트 메소드
extension ViewController: UINavigationControllerDelegate {
}

///*  ---------- 익스텐션 사용하지 않은 코드 --> 지저분함  ---------- */
//class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//    @IBOutlet var imgView: UIImageView!
//
//    @IBAction func pick(_ sender: Any) {
//        // 이미지 피커 컨트롤러 인스턴스 생성
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
//        picker.allowsEditing = true // 이미지 편집 가능 On
//        picker.delegate = self // 델리게이트 지정
//
//        // 이미지 피커 컨트롤러 실행
//        self.present(picker, animated: true)
//    }
//
//    /* 델리게이트 메소드 */
//    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // 이미지 피커 컨트롤러 창 닫기
//        // 내부적으로 알아서 self.presentingViewController 쪽으로 연결시켜 주기 때문에 self.dismiss()로 안해도 됨
//        picker.dismiss(animated: true) { () in
//            // 이미지 피커 컨트롤러가 완전히 닫히고 나서 실행되도록 하기 위해 dismiss(animated:complete:) 메소드 사용
//            // 알림창 호출
//            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
//            self.present(alert, animated: true)
//        }
//    }
//
//    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        // 이미지 피커 컨트롤러 창 닫기
//        picker.dismiss(animated: true) { () in
//            // 이미지를 이미지 뷰에 표시
//            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//            self.imgView.image = img
//        }
//    }
//}

