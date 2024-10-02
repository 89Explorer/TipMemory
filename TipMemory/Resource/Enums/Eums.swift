//
//  Eums.swift
//  TipMemory
//
//  Created by 권정근 on 9/26/24.
//

import Foundation

// MARK: - 여행지 카테고리 열거형
enum ContentCategory: String {
    case attractions = "12"
    case facilities = "14"
    case restaurants = "39"
    case course = "25"
    case shopping = "38"
    
    var contentTypeId: String {
        return self.rawValue
    }
}


// MARK: - 테이블 내의 컬렉션 뷰를 구분하고자 tag 열거형 
enum CollectionViewTags: Int {
    case location = 0
    case category = 1
    case popular = 2
}
