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
    
    // MARK: - Functions
    private func configureConstraints() {
        
        let homeCollectionViewConstraints = [
            homeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            homeCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(homeCollectionViewConstraints)
    }
}


extension HomeBodyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBodyTableCollectionViewCell.identifier, for: indexPath) as? HomeBodyTableCollectionViewCell else { return UICollectionViewCell() }
        
        // cell.backgroundColor = .systemYellow
        return cell
    }
}
