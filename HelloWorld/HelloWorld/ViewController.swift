//
//  ViewController.swift
//  HelloWorld
//
//  Created by 김영빈 on 2023/02/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad() // 부모 클래스에 정의된 viewDidLoad() 내용도 모두 실행
        // Do any additional setup after loading the view.
    }

    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text = "Hello, World!!"
    }
    
}

