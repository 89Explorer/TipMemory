//
//  VisitorResponse.swift
//  TipMemory
//
//  Created by 권정근 on 10/4/24.
//


import Foundation

// 최상위 Response 구조체
struct TatsCnctrRatedListResponse: Codable {
    let response: VisitorResponse
}

// Response 구조체
struct VisitorResponse: Codable {
    let header: VisitorHeader
    let body: VisitorBody
}

// Header 구조체
struct VisitorHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

// Body 구조체
struct VisitorBody: Codable {
    let items: VisitorItems
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

// Items 구조체
struct VisitorItems: Codable {
    let item: [VisitorItem]
}

// Item 구조체 (실제 데이터)
struct VisitorItem: Codable {
    let baseYmd: String  // 날짜
    let areaCd: String   // 지역 코드
    let areaNm: String   // 지역 이름
    let signguCd: String // 시군구 코드
    let signguNm: String // 시군구 이름
    let tAtsNm: String   // 관광 명소 이름
    let cnctrRate: String // 접속률 (percentage)
}
