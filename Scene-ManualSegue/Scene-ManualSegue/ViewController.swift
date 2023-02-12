//
//  ViewController.swift
//  Scene-ManualSegue
//
//  Created by 김영빈 on 2023/02/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func wind(_ sender: Any) {
        // 세그웨이를 실행한다.
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
}

