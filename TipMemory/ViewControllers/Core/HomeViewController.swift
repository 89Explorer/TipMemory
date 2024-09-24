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
        
        view.addSubview(homeView)
        configureConstraints()
        
        categoryViewDelegate()
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
    private func categoryViewDelegate() {
        let homeviewDelegate = homeView.homeheaderView.categoryView.categoryCollectionView
        
        homeviewDelegate.delegate = self
        homeviewDelegate.dataSource = self
        homeviewDelegate.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    
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
            let previousSelectedIndexPath = IndexPath(item: previousSelectedIndex, section: 0)
            
            // 이전 선택 항목이 유효한 경우에만 리로드
            if previousSelectedIndex != categorySelectedIndex {
                homeView.homeheaderView.categoryView.categoryCollectionView.reloadData()
            }
        }
    }
    
    
}


