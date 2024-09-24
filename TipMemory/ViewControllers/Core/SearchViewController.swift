//
//  SearchViewController.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

class SearchViewController: UIViewController {

    // 검색 결과를 보여줄 컨트롤러
    private let searchResultsController = SearchResultsViewController()
    
    // UISearchController 생성
//    private let searchController: UISearchController = {
//        let searchResults = SearchResultsViewController()
//        let searchController = UISearchController(searchResultsController: searchResults)
//        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchController.searchBar.placeholder = "여행지를 검색해주세요"
//        searchController.searchBar.searchBarStyle = .minimal
//        return searchController
//    }()
    
    let searchController: UISearchController = {
        let searchResults = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResults)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.placeholder = "여행지를 검색해주세요"
        searchController.searchBar.searchBarStyle = .default
        searchController.hidesNavigationBarDuringPresentation = true  // 네비게이션 바 숨김 방지
        return searchController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        view.addSubview(searchController.searchBar)  // 서치바를 뷰에 추가
        configureSearchController()

    }
    
    // MARK: - Setup Search Controller
    private func configureSearchController() {
        // 내비게이션 아이템에 서치 컨트롤러 추가
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // searchResultsUpdater를 self로 설정
        searchController.searchResultsUpdater = self
        
        // 서치 컨트롤러의 프레젠테이션 스타일을 설정하지 않음 (기본값 사용)
        searchController.definesPresentationContext = true
        searchController.showsSearchResultsController = true
    }
    

}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating 프로토콜 메서드
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        // 검색 로직을 여기에 추가합니다.
        print("검색어: \(searchText)")
        
        // SearchResultsViewController에 검색 결과 업데이트
        if let resultsController = searchController.searchResultsController as? SearchResultsViewController {
            // 검색어에 따라 데이터를 필터링하거나 업데이트합니다.
            resultsController.updateResults(for: searchText)
        }
    }
}
