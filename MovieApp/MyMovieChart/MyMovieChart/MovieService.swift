//
//  MovieService.swift
//  MyMovieChart
//
//  Created by 김영빈 on 2023/03/01.
//

//import Foundation
//
//struct MovieService {
//    static let shared = MovieService()
//
//    let urlString = "https://openapi.naver.com/v1/search/movie.json?query=%EC%98%81%ED%99%94&display=10&start=1&genre=1"
//    let clientID = Bundle.main.X_NAVER_CLIENT_ID
//    let clientSecret = Bundle.main.X_NAVER_CLIENT_SECRET
//
//    func fetchMovieData(completion: @escaping (Result<Any, Error>) -> ()) {
//        if let url = URL(string: urlString) {
//            // 옵셔널 바인딩을 통해 URL값을 확인하고 URLSession 생성
//            let session = URLSession(configuration: .default) // GET 메소드 사용할거라 기본적인 default session
//
//            // URLRequest 객체 생성 (헤더도 추가)
//            var requestURL = URLRequest(url: url)
//            requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
//            requestURL.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
//
//            // URLRequest 객체로부터 데이터를 얻어오기
//            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    do {
//                        // JSONDecoder : JSON을 디코드해주는 클래스
//                        let decodedData = try JSONDecoder().decode(MovieModel.self, from: safeData)
//                        completion(.success(decodedData))
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//    }
//}
