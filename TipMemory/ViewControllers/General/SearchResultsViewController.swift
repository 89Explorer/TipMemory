//
//  SearchResultsViewController.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    // 검색 결과를 저장할 배열
    private var filteredResults: [String] = []
    
    // 테이블 뷰 생성
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // 임시로 사용할 더미 데이터
    private let allResults = ["Seoul", "Busan", "Jeju", "Incheon", "Daegu"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 오토레이아웃 설정
        configureConstraints()
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    // 검색어에 따라 결과 업데이트
    func updateResults(for query: String) {
        // 검색어가 비어있으면 전체 결과를 보여주고, 그렇지 않으면 필터링된 결과를 보여줌
        if query.isEmpty {
            filteredResults = allResults
        } else {
            filteredResults = allResults.filter { $0.lowercased().contains(query.lowercased()) }
        }
        
        // 테이블 뷰 갱신
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filteredResults[indexPath.row]
        return cell
    }
}
