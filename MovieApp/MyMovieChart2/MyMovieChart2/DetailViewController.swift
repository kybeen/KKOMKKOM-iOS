//
//  DetailViewController.swift
//  MyMovieChart2
//
//  Created by 김영빈 on 2023/09/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var wv: WKWebView!
    var mvo: MovieVO! // 목록 화면에서 전달하는 영화 정보를 받을 변수
    
    override func viewDidLoad() {
//        NSLog("linkurl = \(self.mvo.detail!), title=\(self.mvo.title!)")
        
        // WKNavigationDelegate의 델리게이트 객체를 지정
        self.wv.navigationDelegate = self
        
        // 내비게이션 바의 타이틀에 영화명을 출력한다.
        let navibar = self.navigationItem
        navibar.title = self.mvo.title
        
        if let url = self.mvo.detail {
            // URLRequest 인스턴스를 생성한다.
            if let urlObj = URL(string: url) {
                let req = URLRequest(url: urlObj)
                // loadRequest 메소드를 호출하면서 req를 인자값으로 전달한다.
                self.wv.load(req)
            } else { // URL 형식이 잘못되었을 경우에 대한 예외처리
                // 경고창 형식으로 오류 메시지를 표시해준다.
                let alert = UIAlertController(
                    title: "오류",
                    message: "잘못된 URL입니다.",
                    preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
                    // 이전 페이지로 되돌려보낸다.
                    _ = self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(cancelAction)
                self.present(alert, animated: false)
            }
        } else { // URL 값이 전달되지 않았을 경우에 대한 예외처리
            // 경고창 형식으로 오류 메시지를 표시해준다.
            let alert = UIAlertController(
                title: "오류",
                message: "필수 파라미터가 누락되었습니다.",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
                // 이전 페이지로 되돌려보낸다.
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            self.present(alert, animated: false)
        }
        
    }
}

// MARK: - WKNavigationDelegate 프로토콜 구현
extension DetailViewController: WKNavigationDelegate {
    // 웹 뷰가 콘텐츠를 받기 시작할 떄 호출되는 델리게이트 메소드
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("인디케이터 뷰 시작")
        self.spinner.startAnimating() // 인디케이터 뷰의 애니메이션을 실행
    }
    
    // 콘텐츠 로딩 완료 시 호출되는 델리게이트 메소드
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("인디케이터 뷰 중지")
        self.spinner.stopAnimating() // 인디케이터 뷰의 애니메이션을 중단
    }
    
    // 로딩이 실패했을 때 호출되는 델리게이트 메소드
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("인디케이터 뷰 중지")
        self.spinner.stopAnimating() // 인디케이터 뷰의 애니메이션을 중지
        
        // 경고창 형식으로 오류 메시지를 표시해준다.
        self.alert("상세 페이지를 읽어오지 못했습니다.") {
            // 버튼 클릭 시, 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    // 잘못된 URL, 네트워크 문제로 로딩에 실패했을 경우
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("인디케이터 뷰 중지")
        self.spinner.stopAnimating()
        self.alert("상세 페이지를 읽어오지 못했습니다.") {
            // 버튼 클릭 시, 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - 심플한 경고창 함수 정의용 익스텐션
extension UIViewController {
    func alert(_ message: String, onClick: (() -> Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            onClick?()
        })
        DispatchQueue.main.async {
            self.present(controller, animated: false)
        }
    }
}
