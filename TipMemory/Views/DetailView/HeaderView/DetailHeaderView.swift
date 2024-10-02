//
//  DetailHeaderView.swift
//  TipMemory
//
//  Created by 권정근 on 9/28/24.
//

import UIKit

class DetailHeaderView: UIView {
    
    // MARK: - UI Components
    let headerBasicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailImageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.backward.circle.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "고양 어린이 박물관"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 22)
        label.textColor = .label
        return label
    }()
    
    let detailAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 16)
        label.text = "경기도 고양시 덕양구 화정동 111-1번지 은빛마을 1103동"
        label.textColor = .label
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(headerBasicView)
        
        headerBasicView.addSubview(detailImageCollectionView)
        headerBasicView.addSubview(detailTitleLabel)
        headerBasicView.addSubview(detailAddressLabel)
        headerBasicView.addSubview(backButton)
        headerBasicView.addSubview(pageControl)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let headerBasicViewConstraints = [
            headerBasicView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBasicView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBasicView.topAnchor.constraint(equalTo: topAnchor),
            headerBasicView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let detailImageCollectionViewConstraints = [
            detailImageCollectionView.leadingAnchor.constraint(equalTo: headerBasicView.leadingAnchor),
            detailImageCollectionView.trailingAnchor.constraint(equalTo: headerBasicView.trailingAnchor),
            detailImageCollectionView.topAnchor.constraint(equalTo: headerBasicView.topAnchor),
            detailImageCollectionView.widthAnchor.constraint(equalTo: headerBasicView.widthAnchor),
            detailImageCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let backButtonConstraints = [
            backButton.leadingAnchor.constraint(equalTo: headerBasicView.leadingAnchor,constant: 25),
            backButton.topAnchor.constraint(equalTo: headerBasicView.topAnchor, constant: 60)
        ]
        
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: headerBasicView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: detailImageCollectionView.bottomAnchor, constant: -15)
        ]
    
        let detailTitleLabelConstraints = [
            detailTitleLabel.leadingAnchor.constraint(equalTo: headerBasicView.leadingAnchor, constant: 15),
            detailTitleLabel.topAnchor.constraint(equalTo: detailImageCollectionView.bottomAnchor, constant: 15)
        ]
        
        let detailAddressLabelConstraints = [
            detailAddressLabel.leadingAnchor.constraint(equalTo: headerBasicView.leadingAnchor, constant: 15),
            detailAddressLabel.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(headerBasicViewConstraints)
        NSLayoutConstraint.activate(detailImageCollectionViewConstraints)
        NSLayoutConstraint.activate(backButtonConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
        NSLayoutConstraint.activate(detailTitleLabelConstraints)
        NSLayoutConstraint.activate(detailAddressLabelConstraints)
    }
    
    
}
