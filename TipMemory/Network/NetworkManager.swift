//
//  NetworkManager.swift
//  TipMemory
//
//  Created by 권정근 on 9/26/24.
//

import Foundation

// MARK: - Constants
struct Constants {
    static let api_key = "jlK%2B0ig7iLAbdOuTJsnkp6n0RdeEMtGKsw53jEMbKm3PcB7NFTSeUrnXixogiuvNtHQXeqxgV88buRZvTjG73w%3D%3D"
    static let base_URL = "https://apis.data.go.kr/B551011/KorService1"
}

// MARK: - NetworkManager
class NetworkManager {
    
    static let shared = NetworkManager()
    
    // 홈화면에서 전지역을 상대로 검색하는 함수
    func getKeywordnData(contentTypeId: String, pageNo: String = "1", completion: @escaping (Result<AttractionResponse, Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/areaBasedList1")
        
        // 쿼리 아이템 설정
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: pageNo),
            URLQueryItem(name: "MobileOS", value: "ETC"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "listYN", value: "Y"),
            URLQueryItem(name: "arrange", value: "R"),
            URLQueryItem(name: "contentTypeId", value: contentTypeId)
        ]
        
        // 퍼센트 인코딩 후 "+"를 "%2B"로 대체
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        // URL 생성
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(AttractionResponse.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    // 사용자의 위치 기반으로 근처 관광지를 검색한다.
    func getSpotDataFromLocation(mapX: String, mapY: String, radius: String = "10000", contentTypeId: String = "12" ,completion: @escaping (Result<[Item], Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/locationBasedList1")
        
        // 쿼리 아이템 설정
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: "1"),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "listYN", value: "Y"),
            URLQueryItem(name: "arrange", value: "O"),
            URLQueryItem(name: "mapX", value: mapX),
            URLQueryItem(name: "mapY", value: mapY),
            URLQueryItem(name: "radius", value: radius),
            URLQueryItem(name: "contentTypeId", value: contentTypeId)
        ]
        
        // 퍼센트 인코딩 후 "+"를 "%2B"로 대체
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        // URL 생성
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(AttractionResponse.self, from: data)
                completion(.success(results.response.body.items.item))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    // contentId를 통해 이미지를 불러오는 함수
    func getSpotImage(contentId: String, completion: @escaping (Result<[ImageItem], Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/detailImage1")
        
        // 쿼리 아이템 설정
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "contentId", value: contentId),
            URLQueryItem(name: "imageYN", value: "Y"),
            URLQueryItem(name: "subImageYN", value: "Y"),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: "1")
        ]
        
        // 퍼센트 인코딩 후 "+"를 "%2B"로 대체
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        // URL 생성
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                    print("error 발생 1")
                }
                return
            }
            
            do {
                
                let results = try JSONDecoder().decode(ImageResponse.self, from: data)
                // 안전하게 items를 언래핑하고 nil일 경우 빈 배열 반환
                let items = results.response.body.items?.item ?? []
                completion(.success(items))
                
            } catch {
                completion(.failure(error))
                print("error 발생 2")
            }
        }
        task.resume()
    }
    
    
    // 외부 API를 통해 소개 정보를 얻어오는 함수
    func getSpotDetail(contentId: String, contentTypeId: String, completion: @escaping (Result<[InfoItem], Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/detailIntro1")
        
        // 쿼리 아이템 설정
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "contentId", value: contentId),
            URLQueryItem(name: "contentTypeId", value: contentTypeId),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: "1")
        ]
        
        // 퍼센트 인코딩 후 "+"를 "%2B"로 대체
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        // URL 생성
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                    
                    print("error 발생 1")
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(UnifiedResponse.self, from: data)
                let infoItem = results.response.body.items?.item ?? []
                
                completion(.success(infoItem))
            } catch let jsonError {
                completion(.failure(jsonError))
                print("JSON 디코딩 에러: \(jsonError.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // 외부 API 정보를 통해 해당 소개 글 받아오는 함수
    func getCommonData(contentId: String, contentTypeId: String, completion: @escaping (Result<Item, Error>) -> Void) {
        
        var components = URLComponents(string: "\(Constants.base_URL)/detailCommon1")
        
        // 쿼리 아이템 설정
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "contentId", value: contentId),
            URLQueryItem(name: "contentTypeId", value: contentTypeId),
            URLQueryItem(name: "defaultYN", value: "Y"),
            URLQueryItem(name: "firstImageYN", value: "Y"),
            URLQueryItem(name: "areacodeYN", value: "Y"),
            URLQueryItem(name: "catcodeYN", value: "Y"),
            URLQueryItem(name: "addrinfoYN", value: "Y"),
            URLQueryItem(name: "mapinfoYN", value: "Y"),
            URLQueryItem(name: "overviewYN", value: "Y"),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: "1") // 페이지 번호를 기본값으로 설정
        ]
        
        // 퍼센트 인코딩 후 "+"를 "%2B"로 대체
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        // URL 생성
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                    
                    print("error 발생 1")
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(AttractionResponse.self, from: data)
                let item = results.response.body.items.item[0]
                completion(.success(item))
                
            } catch let jsonError {
                completion(.failure(jsonError))
                print("JSON 디코딩 에러: \(jsonError.localizedDescription)")
            }
        }
        task.resume()
    }
}


