//
//  ImageResponse.swift
//  TipMemory
//
//  Created by 권정근 on 9/30/24.
//

import Foundation

// MARK: - Main Response Model
struct ImageResponse: Codable {
    let response: ImageResponseBody
}

struct ImageResponseBody: Codable {
    let header: ResponseHeader
    let body: ImageResponseBodyContent
}

struct ResponseHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

// items가 빈문자열 형태 ("") 일 경우를 대비하기 위해 수정 코드
struct ImageResponseBodyContent: Codable {
    let items: ImageItems?
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
    
    // 커스텀 디코딩 로직 추가
    enum CodingKeys: String, CodingKey {
        case items, numOfRows, pageNo, totalCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numOfRows = try container.decode(Int.self, forKey: .numOfRows)
        pageNo = try container.decode(Int.self, forKey: .pageNo)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        
        // items를 빈 문자열인 경우 nil로 처리
        if let itemsString = try? container.decode(String.self, forKey: .items), itemsString.isEmpty {
            items = nil
        } else {
            items = try? container.decode(ImageItems.self, forKey: .items)
        }
    }
}

struct ImageItems: Codable {
    let item: [ImageItem]?
}

// MARK: - Image Item Model
struct ImageItem: Codable {
    let contentid: String
    let originimgurl: String
    let imgname: String
    let smallimageurl: String
    let cpyrhtDivCd: String
    let serialnum: String
}
