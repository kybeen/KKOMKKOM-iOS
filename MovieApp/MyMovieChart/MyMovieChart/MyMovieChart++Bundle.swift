//
//  MyMovieChart++Bundle.swift
//  MyMovieChart
//
//  Created by 김영빈 on 2023/03/01.
//

import Foundation

extension Bundle {
    
    // plist 파일 경로 불러오기
    // forResource: plist파일명
    var X_NAVER_CLIENT_ID: String {
        guard let file = self.path(forResource: "NaverMovieInfo", ofType: "plist") else { return "" }
        
        // plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["X_NAVER_CLIENT_ID"] as? String else {
            fatalError("NaverMovieInfo.plist의 X_NAVER_CLIENT_ID에 유효한 값 설정을 해주세요")
        }
        return key
    }
    
    var X_NAVER_CLIENT_SECRET: String {
        guard let file = self.path(forResource: "NaverMovieInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["X_NAVER_CLIENT_SECRET"] as? String else {
            fatalError("NaverMovieInfo.plist의 X_NAVER_CLIENT_SECRET에 유효한 값 설정을 해주세요")
        }
        return key
    }
}
