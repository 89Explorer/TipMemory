//
//  Functions.swift
//  TipMemory
//
//  Created by 권정근 on 10/2/24.
//

import Foundation


// MARK: - <br> 태그를 제거하는 함수
func removeHTMLTags(from text: String) -> String {
    // <br> 태그를 줄바꿈으로 바꾸고, 다른 HTML 태그는 모두 제거합니다.
    var cleanedText = text.replacingOccurrences(of: "<br>", with: "\n")
    cleanedText = cleanedText.replacingOccurrences(of: "<br/>", with: "\n")
    
    // 추가로, 다른 HTML 태그들도 제거하고 싶다면, 아래 정규식을 사용하여 모든 태그를 제거할 수 있습니다.
    if let regex = try? NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive) {
        cleanedText = regex.stringByReplacingMatches(in: cleanedText, options: [], range: NSRange(location: 0, length: cleanedText.count), withTemplate: "")
    }
    
    return cleanedText
}
