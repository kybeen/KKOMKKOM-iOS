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
    // 현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        // list 배열 변수의 클로저가 실행되는 시점에 dataset 베열이 초기화되어 있다고 보장할 수 없기 때문에 lazy 키워드 사용
        var datalist = [MovieVO]()
        return datalist
    }()
    
    @IBOutlet var moreBtn: UIButton!
    
    // 더보기 버튼 클릭 시 호출되는 메소드
    @IBAction func more(_ sender: Any) {
        // 현재 페이지 값에 1을 추가한다.
        self.page += 1
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
        self.tableView.reloadData()
    }
    
    // 뷰가 처음 메모리에 로드될 때 호출되는 메소드
    override func viewDidLoad() {
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
    }
    
    // 영화 차트 API를 호출해주는 메소드
    func callMovieAPI() {
        // ① 호핀 API 호출을 위한 URI를 생성
        let url = "http://115.68.183.178:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        // ② REST API를 호출
        do {
            let apidata = try! Data(contentsOf: apiURI)
            
            // ③ 데이터 전송 결과를 로그로 출력
            let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다."
            NSLog("API Result=\(log)")
            
            // ④ JSON 객체를 파싱하여 NSDictionary 객체로 변환
            do {
                let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
                
                // ⑤ 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
                let hoppin = apiDictionary["hoppin"] as! NSDictionary
                let movies = hoppin["movies"] as! NSDictionary
                let movie = movies["movie"] as! NSArray
                
                // ⑥ Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
                for row in movie {
                    // 순회 상수를 NSDictionary 타입으로 캐스팅
                    let r = row as! NSDictionary
                    
                    // 테이블 뷰 리스트를 구성할 데이터 형식
                    let mvo = MovieVO()
                    
                    // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                    mvo.title = r["title"] as? String
                    mvo.description = r["genreNames"] as? String
                    mvo.thumnail = r["thumbnailImage"] as? String
                    mvo.detail = r["linkUrl"] as? String
                    mvo.rating = (r["ratingAverage"] as! NSString).doubleValue
                    
                    // 웹상에 있는 이미지를 읽어와 UIImage 객체로 바로 저장
                    let url: URL! = URL(string: mvo.thumnail!)
                    let imageData = try! Data(contentsOf: url)
                    mvo.thumbnailImage = UIImage(data: imageData)
                    
                    // list 배열에 추가
                    self.list.append(mvo)
                }
                
                // ⑦ 전체 데이터 카운트를 얻는다.
                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
                
                // ⑧ totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다.
                if (self.list.count) >= totalCount {
                    self.moreBtn.setTitle("마지막 목록입니다.", for: .normal)
                    self.moreBtn.isEnabled = false
                }
            } catch {
                // 오류처리
                NSLog("Parse Error!!")
            }
        } catch {
            NSLog("API 호출 실패!!")
        }
    }
    
    // MARK: - 썸네일 이미지를 처리하는 메소드 (메모이제이션 기법 적용)
    func getThumbnailImage(_ index: Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션 : 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData) // UIImage를 MovieVO 객체에 우선 저장
            
            return mvo.thumbnailImage! // 저장된 이미지를 반환
        }
    }
    
    // MARK: - 생성해야 할 생의 개수를 반환하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // MARK: - 테이블 뷰 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        
        // 로그 출력
        NSLog("제목:\(row.title), 호출된 행번호:\(indexPath.row)")
        
        /// 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴 (스토리보드에 정의된 프로토타입 셀을 찾고, 이를 인스턴스로 생성하여 갖고옴)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
//        cell.thumbnail.image = UIImage(named: row.thumnail!)
        
//        // 썸네일 경로를 인자값으로 하는 URL 객체를 생성
//        let url: URL! = URL(string: row.thumnail!)
//        // 이미지를 읽어와 Data 객체에 저장
//        let imageData = try! Data(contentsOf: url)
//        // UIImage 객체를 생성하여 아울렛 변수의 image 속성에 대입
//        cell.thumbnail.image = UIImage(data: imageData)
        
        // 비동기 방식으로 썸네일 이미지를 읽어옴
        DispatchQueue.main.async {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        }
        
        return cell
    }
    
    // MARK: - 리스트 셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
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
