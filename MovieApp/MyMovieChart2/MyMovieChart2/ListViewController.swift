//
//  ListViewController.swift
//  MyMovieChart2
//
//  Created by 김영빈 on 2023/09/19.
//

import UIKit

/*
 커스텀 클래스로 프로토타입 셀의 객체 제어하기
 */
class ListViewController: UITableViewController {
    // 튜플 아이템으로 구성된 데이터 세트
    var dataset = [
        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95, "darknight.jpg"),
        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
        ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
    ]
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        // list 배열 변수의 클로저가 실행되는 시점에 dataset 베열이 초기화되어 있다고 보장할 수 없기 때문에 lazy 키워드 사용
        var datalist = [MovieVO]()
        for (title, desc, opendate, rating, thumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumnail = thumbnail
            
            datalist.append(mvo)
        }
        return datalist
    }()
    
    // MARK: - 생성해야 할 생의 개수를 반환하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // MARK: - 테이블 뷰 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        
        /// 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴 (스토리보드에 정의된 프로토타입 셀을 찾고, 이를 인스턴스로 생성하여 갖고옴)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail.image = UIImage(named: row.thumnail!)
        
        return cell
    }
    
    // MARK: - 리스트 셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
    override func viewDidLoad() {
        
    }
}










//import UIKit
//
//class ListViewController: UITableViewController {
//    // 튜플 아이템으로 구성된 데이터 세트
//    var dataset = [
//        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95, "darknight.jpg"),
//        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
//        ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
//    ]
//
//    // 테이블 뷰를 구성할 리스트 데이터
//    lazy var list: [MovieVO] = {
//        // list 배열 변수의 클로저가 실행되는 시점에 dataset 베열이 초기화되어 있다고 보장할 수 없기 때문에 lazy 키워드 사용
//        var datalist = [MovieVO]()
//        for (title, desc, opendate, rating, thumbnail) in self.dataset {
//            let mvo = MovieVO()
//            mvo.title = title
//            mvo.description = desc
//            mvo.opendate = opendate
//            mvo.rating = rating
//
//            datalist.append(mvo)
//        }
//        return datalist
//    }()
//
//    // MARK: - 생성해야 할 생의 개수를 반환하는 메소드
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.list.count
//    }
//
//    // MARK: - 테이블 뷰 행을 구성하는 메소드
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        /// 주어진 행에 맞는 데이터 소스를 읽어온다.
//        let row = self.list[indexPath.row]
//        /// 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴 (스토리보드에 정의된 프로토타입 셀을 찾고, 이를 인스턴스로 생성하여 갖고옴)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
////        cell.textLabel?.text = row.title
////        cell.detailTextLabel?.text = row.description
//
//        /* 커스텀 프로토타입 셀 */
//        /// 프로토타입 셀의 객체를 참조
//        let title = cell.viewWithTag(101) as? UILabel // 영화제목
//        let desc = cell.viewWithTag(102) as? UILabel // 영화요약
//        let opendate = cell.viewWithTag(103) as? UILabel // 영화개봉일
//        let rating = cell.viewWithTag(104) as? UILabel // 영화별점
//
//        /// 데이터 소스에 저장된 값을 각 레이블 변수에 할당
//        title?.text = row.title
//        desc?.text = row.description
//        opendate?.text = row.opendate
//        rating?.text = "\(row.rating!)"
//
//        return cell
//    }
//
//    // MARK: - 리스트 셀을 선택했을 때 호출되는 메소드
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
//    }
//
//    override func viewDidLoad() {
//
//    }
//}
