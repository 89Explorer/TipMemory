//
//  AttractionResponse.swift
//  TipMemory
//
//  Created by 권정근 on 9/26/24.
//


import Foundation

// AttractionResponse: 기존 응답 구조
struct AttractionResponse: Codable {
    let response: Response
}

// Response: 기존 응답 구조
struct Response: Codable {
    let header: Header
    let body: Body
}

// Header: 기존 응답 구조
struct Header: Codable {
    let resultCode: String
    let resultMsg: String
}

// Body: 기존 응답 구조에 이미지 데이터 추가
struct Body: Codable {
    let items: Items
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

// Items: 기존 아이템 구조
struct Items: Codable {
    let item: [Item]
}

// Item: 기존 관광지 정보에 이미지 관련 필드 추가
struct Item: Codable {
    let addr1: String?
    let addr2: String?
    let areacode: String?
    let booktour: String?
    let cat1: String?
    let cat2: String?
    let cat3: String?
    let contentid: String
    let contenttypeid: String
    let createdtime: String?
    let firstimage: String?
    let firstimage2: String?
    let cpyrhtDivCd: String?
    let mapx: String?
    let mapy: String?
    let mlevel: String?
    let modifiedtime: String?
    let sigungucode: String?
    let tel: String?
    let title: String?
    let zipcode: String?
}
