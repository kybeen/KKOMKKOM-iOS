//
//  MovieCell.swift
//  MyMovieChart2
//
//  Created by 김영빈 on 2023/09/20.
//

import UIKit

// MARK: - 프로토타입 셀에 대한 커스텀 클래스
class MovieCell: UITableViewCell {
    @IBOutlet var title: UILabel! // 영화제목
    @IBOutlet var desc: UILabel! // 영화 설명
    @IBOutlet var opendate: UILabel! // 개봉일
    @IBOutlet var rating: UILabel! // 평점
    @IBOutlet var thumbnail: UIImageView! // 썸네일 이미지
}
