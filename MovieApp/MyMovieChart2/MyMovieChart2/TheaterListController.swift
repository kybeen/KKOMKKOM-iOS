//
//  TheaterListController.swift
//  MyMovieChart2
//
//  Created by 김영빈 on 2023/09/24.
//

import UIKit

class TheaterListController: UITableViewController {
    // API를 통해 불러온 데이터를 저장할 배열 변수
    var list = [NSDictionary]()
    // 읽어올 데이터의 시작위치
    var startPoint = 0
    
    override func viewDidLoad() {
        // API를 호출한다.
        self.callTheaterAPI()
    }
    
    // 더보기 버튼 클릭 시 동작
    @IBAction func moreTheater(_ sender: Any) {
        callTheaterAPI() // API를 호출해서 100개 극장을 더 불러온다.
        self.tableView.reloadData() // 테이블 뷰 갱신
    }
    
    // API로부터 극장 정보를 읽어오는 메소드
    func callTheaterAPI() {
        // ① URL을 구성하기 위한 상수값을 선언한다.
        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list" // API 요청 주소
        let sList = 100 // 불러올 데이터 갯수
        let type = "json" // 데이터 형식
        
        // ② 인자값들을 모아 URL 객체로 정의한다.
        let urlObj = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        do {
            // ③ NSString 객체를 이용하여 API를 호출하고 그 결과값을 인코딩된 문자열로 받아온다.
            /// 영화 차트 API는 UTF-8로, 영화관 API는 EUC-KR로 인코딩되어 있다.
            /// UTF-8은 한글까지 문제없이 처리할 수 있지만, EUC-KR은 데이터를 읽어올 때 인코딩 처리를 해야 한다. 그렇기 때문에 Data 객체 대신 NSString 객체를 이용하여 API 데이터를 읽어온다.
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            
            // ④ 문자열로 받은 데이터를 UTF-8로 인코딩처리한 Data로 변환한다.
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
            
            do {
                // ⑤ Data 객체를 파싱하여 NSArray 객체로 변환한다.
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                // ⑥ 읽어온 데이터를 순회하면서 self.list 배열에 추가한다.
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
            } catch {
                // 경고창 형식으로 오류 메시지를 표시해준다.
                let alert = UIAlertController(title: "실패",
                                              message: "데이터 분석이 실패하였습니다.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self.present(alert, animated: false)
            }
            // ⑦ 읽어와야 할 다음 페이지의 데이터 시작 위치를 구해 저장해둔다.
            self.startPoint += sList
        } catch {
            // 경고창 형식으로 오류 메시지를 표시해준다.
            let alert = UIAlertController(title: "실패",
                                          message: "데이터를 불러오는데 실패하였습니다.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // self.list 배열에서 행에 맞는 데이터를 꺼냄
        let obj = self.list[indexPath.row]
        
        // 재사용 큐로부터 tCell 식별자에 맞는 셀 객체를 전달받음
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        cell.name.text = obj["상영관명"] as? String
        cell.tel.text = obj["연락처"] as? String
        cell.addr.text = obj["소재지도로명주소"] as? String
        
        return cell
    }
    // 세그웨이 실행 전 전처리 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_map") { // 실행된 세그웨이의 식별자가 segue_map 이라면
            // 선택된 셀의 행 정보
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            // 선택된 셀에 사용된 데이터
            let data = self.list[path!.row]
            // 세그웨이가 이동할 목적지 뷰 컨트롤러 객체를 구하고, 선언된 param 변수에 데이터를 연결해준다.
            (segue.destination as? TheaterViewController)?.param = data
        }
    }
}

