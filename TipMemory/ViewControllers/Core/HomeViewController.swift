//
//  HomeViewController.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - Variables
    private var categories: [String] = ["자연 여행", "문화 여행", "음식 여행", "코스 여행", "쇼핑 여행"]
    private var categoriesImage: [String] = ["Nature", "Museum", "Restaurant", "Stroll", "Shopping"]
    private var categorySelectedIndex: Int = 0
    
    // 홈 화면 테이블 섹션
    private var sections: [String] = ["카테고리 별 여행지", "현재 위치 기준 여행지", "인기 있는 여행지"]
    
    
    
    
    
    // MARK: - UI Components
    let homeView: HomeMainView = {
        let view = HomeMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // navigationController?.navigationBar.isTranslucent = false
        view.addSubview(homeView)
        configureConstraints()
        
        categoryViewDelegate()
        tableViewDelegate()
    }
    
    // MARK: - Total Layouts
    private func configureConstraints() {
        
        let homeViewConstraints = [
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(homeViewConstraints)
    }
    
    // MARK: - Functions
    // 카테고리 컬렉션 델리게이트 함수
    private func categoryViewDelegate() {
        
        let homeviewDelegate = homeView.homeheaderView.categoryView.categoryCollectionView
        
        homeviewDelegate.delegate = self
        homeviewDelegate.dataSource = self
        homeviewDelegate.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    // 홈 화면 섹션 테이블 델리게이트 함수
    private func tableViewDelegate() {
        let homeTableDelegate = homeView.homeBodyView.homeBodyTable
        
        homeTableDelegate.delegate = self
        homeTableDelegate.dataSource = self
        homeTableDelegate.register(HomeBodyTableViewCell.self, forCellReuseIdentifier: HomeBodyTableViewCell.identifier)
    }
    
    // 테이블 섹션 타이틀 "더보기" 버튼 함수
    @objc func moreButtonTapped(_ sender: UIButton) {
        print("더 보기 버튼 클릭 ")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        let title = categories[indexPath.row]
        let image = categoriesImage[indexPath.row]
        let isSelected = indexPath.item == categorySelectedIndex
        
        cell.configureCategory(title: title, isSelected: isSelected, image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == homeView.homeheaderView.categoryView.categoryCollectionView {
            let previousSelectedIndex = categorySelectedIndex    // 이전에 선택된 인덱스 저장
            categorySelectedIndex = indexPath.item    // 새로운 선택 인덱스로 업데이트
            
            _ = IndexPath(item: categorySelectedIndex, section: 0)
            _ = IndexPath(item: previousSelectedIndex, section: 0)
            
            // 이전 선택 항목이 유효한 경우에만 리로드
            if previousSelectedIndex != categorySelectedIndex {
                homeView.homeheaderView.categoryView.categoryCollectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBodyTableViewCell.identifier) as? HomeBodyTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(sections[section])"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        label.textColor = .label
        label.backgroundColor = .clear
        label.textAlignment = .left
        
        headerView.addSubview(label)
        
        let moreButton = UIButton(type: .system)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setTitle("더 보기", for: .normal)
        moreButton.titleLabel?.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        moreButton.setTitleColor(.label, for: .normal)
        moreButton.addTarget(self, action: #selector(moreButtonTapped(_:)), for: .touchUpInside)
        
        headerView.addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            
            // 더보기 버튼의 제약조건
            moreButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            moreButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: -5),
        ])
        
        return headerView
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
}
