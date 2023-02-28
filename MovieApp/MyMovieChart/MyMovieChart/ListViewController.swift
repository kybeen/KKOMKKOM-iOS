import UIKit
import Foundation
import Alamofire

class ListViewController: UITableViewController {
    // 튜플 아이템으로 구성된 데이터 세트
    var dataset = [
        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95, "darknight.jpg"),
        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
        ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
    ]
    
    // 테이블 뷰를 구성할 리스트 데이터
    /*
     [ lazy 키워드 ]
     - 참조되는 시점에 맞추어 초기화되므로 메모리 낭비를 줄일 수 있다.
     - 일반 저장 프로퍼티 끼리는 초기화 순서의 불확실성으로 인해 서로를 참조할 수 없다. 하지만 lazy 키워드가 붙은 프로퍼티는 다른 일반 프로퍼티들이 초기화된 후 맨 마지막에 초기화될 뿐만 아니라, 초기화되는 시점도 통제할 수 있다.
     - 따라서 lazy 키워드가 붙은 list의 초기화 클로저 구문 안에서 다른 프로퍼티인 dataset을 참조할 수 있다.
     */
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for (title, desc, opendate, rating, thumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = thumbnail
            // 배열에 추가
            datalist.append(mvo)
        }
        return datalist
    }()
    
    
    /* 테이블 뷰 - 데이터 소스 연동 메소드 구현 */
    // 테이블 뷰가 생성해야 할 행의 개수를 반환
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // 테이블 뷰의 각 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        // 인자값으로 입력받은 아이디("ListCell")을 이용하여 스토리보드에 정의된 프로토타입 셀을 찾고, 이를 인스턴스로 생성하여 제공함 (재사용 큐 활용 - 책 524p, 555p)
        // 커스텀 클래스인 MovieCell로 캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
//        cell.textLabel?.text = row.title
//        cell.detailTextLabel?.text = row.description
        /* 커스텀 프로토타입 셀 구성 */
        // 프로토타일 셀의 객체 참조
//        let title = cell.viewWithTag(101) as? UILabel // 영화 제목
//        let desc = cell.viewWithTag(102) as? UILabel // 영화 요약
//        let opendate = cell.viewWithTag(103) as? UILabel // 개봉일
//        let rating = cell.viewWithTag(104) as? UILabel // 평점
//        // 참조된 레이블 객체에 값 넣어주기
//        title?.text = row.title
//        desc?.text = row.description
//        opendate?.text = row.opendate
//        rating?.text = "\(row.rating!)"
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail.image = UIImage(named: row.thumbnail!)
        
        // 구성된 셀을 반환
        return cell
    }
    
    // 사용자의 행 클릭 시 액션 처리를 위한 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
    override func viewDidLoad() {
//        /* API 호출하기 - 루비페이퍼 API 먹통이라 네이버 API로 대체 */
//        // (1) 호핀 API 호출을 위한 URI를 생성
//        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
//        let apiURI: URL! = URL(string: url)
//        // (2) REST API를 호출
//        let apidata = try! Data(contentsOf: apiURI)
//        // (3) 데이터 전송 결과를 로그로 출력 (반드시 필요한 코드는 아님)
//        // 인자로 받은 Data 객체를 문자열로 변환해주기 위해 String이 아닌 NSString 타입으로 변환
//        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
//        NSLog("API Result = \(log)")
        
        /* API 호출하기 - 네이버 API */
        let url = "https://openapi.naver.com/v1/search/movie.json?query=%EC%98%81%ED%99%94&display=10&start=1&genre=1"
        let naverClientId = "9mhe5KqS8bkpbFBuGJek" //
        let naverClientSecret = "OPaVHO5wiD" //
        
        AF.request(url,
                    method: .get,
                    parameters: nil,
                    encoding: URLEncoding.default,
                    headers: [
                        "X-Naver-Client-Id": naverClientId,
                        "X-Naver-Client-Secret": naverClientSecret
                    ]
        )
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print("success \(data)")
            case .failure(let error):
                print("error \(error)")
            }
        }


        
        
    }
}
