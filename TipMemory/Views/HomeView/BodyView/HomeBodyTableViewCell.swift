//
//  HomeBodyTableViewCell.swift
//  TipMemory
//
//  Created by 권정근 on 9/25/24.
//

import UIKit

class HomeBodyTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "HomeBodyTableViewCell"
    
    var reciveData: [Item] = []
    
    
    // MARK: - UI Components
    let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 250)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeBodyTableCollectionViewCell.self, forCellWithReuseIdentifier: HomeBodyTableCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // contentView.backgroundColor = .systemBackground
        contentView.addSubview(homeCollectionView)
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let homeCollectionViewConstraints = [
            homeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            homeCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(homeCollectionViewConstraints)
    }
    
    // MARK: - Functions
    // 데이터를 전달받아 컬렉션 뷰에 적용
    func configure(with items: [Item]) {
        self.reciveData = items
        homeCollectionView.reloadData()  // 데이터를 새로고침하여 컬렉션 뷰 갱신
    }
}


extension HomeBodyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reciveData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBodyTableCollectionViewCell.identifier, for: indexPath) as? HomeBodyTableCollectionViewCell else { return UICollectionViewCell() }
        
        // 데이터를 컬렉션 뷰 셀에 전달하여 구성
        cell.configureData(with: reciveData[indexPath.item])
        
        return cell
    }
}
