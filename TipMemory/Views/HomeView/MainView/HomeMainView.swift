//
//  HomeMainView.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

class HomeMainView: UIView {
    
    // MARK: - UI Components
    private let basicView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never // Safe Area 인셋 무시
        return view
    }()
    
    let homeheaderView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(basicView)
        basicView.addSubview(homeheaderView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: trailingAnchor),
            basicView.topAnchor.constraint(equalTo: topAnchor),
            basicView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let homeheaderViewConstraints = [
            homeheaderView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor),
            homeheaderView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor),
            homeheaderView.topAnchor.constraint(equalTo: basicView.topAnchor),
            homeheaderView.widthAnchor.constraint(equalTo: basicView.widthAnchor),
            homeheaderView.heightAnchor.constraint(equalToConstant: 350)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(homeheaderViewConstraints)
    }
}
