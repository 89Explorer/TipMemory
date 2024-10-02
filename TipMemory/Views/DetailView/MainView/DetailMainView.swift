//
//  DetailMainView.swift
//  TipMemory
//
//  Created by 권정근 on 9/28/24.
//

import UIKit

class DetailMainView: UIView {
    
    
    // MARK: - UI Components
    private let basicView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never // Safe Area 인셋 무시
        return view
    }()
    
    let detailheaderView: DetailHeaderView = {
        let view = DetailHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailbodyView: DetailBodyView = {
        let view = DetailBodyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(basicView)
        basicView.addSubview(detailheaderView)
        basicView.addSubview(detailbodyView)
        
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
        
        let detailheaderViewConstraints = [
            detailheaderView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor),
            detailheaderView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor),
            detailheaderView.topAnchor.constraint(equalTo: basicView.topAnchor),
            detailheaderView.widthAnchor.constraint(equalTo: basicView.widthAnchor),
            detailheaderView.heightAnchor.constraint(equalToConstant: 380)
        ]
        
        let detailbodyViewConstraints = [
            detailbodyView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor),
            detailbodyView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor),
            detailbodyView.topAnchor.constraint(equalTo: detailheaderView.bottomAnchor),
            detailbodyView.widthAnchor.constraint(equalTo: basicView.widthAnchor),
            detailbodyView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(detailheaderViewConstraints)
        NSLayoutConstraint.activate(detailbodyViewConstraints)
    }
}
