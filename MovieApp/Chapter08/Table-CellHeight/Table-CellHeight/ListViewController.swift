import UIKit

class ListViewController: UITableViewController {
    // 테이블 뷰에 연결될 데이터를 저장하는 배열
    var list = [String]()
    
    @IBAction func add(_ sender: Any) {
        // (1) 알림창 객체의 인스턴스를 생성
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요.", preferredStyle: .alert)
        
        // (2) 알림창에 입력폼을 추가한다.
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        
        // (3) OK 버튼 객체를 생성한다. : 아직 알림창 객체에 버튼이 등록되지 않은 상태
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            // (4) 알림창의 0번째 입력필드에 값이 있다면
            if let title = alert.textFields?[0].text {
                // (5) 배열에 입력된 값을 추가하고 테이블을 갱신
                self.list.append(title)
                self.tableView.reloadData() // 데이터 소스를 다시 읽어와 테이블 뷰 목록을 갱신
            }
        }
        // 취소 버튼 객체를 생성한다.
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        // (6) 알림창 객체에 버튼 객체를 등록한다.
        alert.addAction(ok)
        alert.addAction(cancel)
        
        // (7) 알림창을 띄운다.
        self.present(alert, animated: true)
    }
    
    // MARK: - 테이블 뷰의 가로 행 수 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // MARK: - 테이블 뷰의 가로 행 내용 결정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // (1) "cell" 아이디를 가진 셀을 읽어온다. 없으면 UITableViewCell 인스턴스를 생성한다. (nil 병합 연산자 ?? 사용 - 582p)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        // 셀의 기본 텍스트 레이블 행 수 제한을 없앤다. --> 글자의 길이에 따라 레이블의 높이가 자연스럽게 늘어남
        cell.textLabel?.numberOfLines = 0
        
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당한다.
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    // MARK: - 입력된 글의 길이를 체크하여 셀의 높이를 조절해주는 메소드
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = self.list[indexPath.row]
//
//        // 높이를 조절해준다. --> 기본 높이 60 + 글의 길이가 30자를 넘어갈 때마다 20만큼씩 높이를 늘려줌.
//        let height = CGFloat(60 + (row.count / 30) * 20)
//        return height
//    }
    
    // MARK: - 셀프 사이징 셀 적용하기
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50 // 대충의(임시) 높이값
        self.tableView.rowHeight = UITableView.automaticDimension // 높이 동적으로 설정
    }
}
