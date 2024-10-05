//
//  YoutubeSearchResponse.swift
//  TipMemory
//
//  Created by 권정근 on 10/5/24.
//

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
    
    // videoId를 추출하는 함수 추가
    var videoId: String? {
        return id.kind == "youtube#video" ? id.videoId : nil
    }
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String?
}
