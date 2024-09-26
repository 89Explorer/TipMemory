//
//  HomeBodyView.swift
//  TipMemory
//
//  Created by 권정근 on 9/25/24.
//

import UIKit

class HomeBodyView: UIView {
    
    // MARK: - UI Components
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let homeBodyTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.tintColor = .label
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(basicView)
        basicView.addSubview(homeBodyTable)        
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
        
        let homeBodyTableConstraints = [
            homeBodyTable.leadingAnchor.constraint(equalTo: basicView.leadingAnchor),
            homeBodyTable.trailingAnchor.constraint(equalTo: basicView.trailingAnchor),
            homeBodyTable.topAnchor.constraint(equalTo: basicView.topAnchor),
            homeBodyTable.bottomAnchor.constraint(equalTo: basicView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(homeBodyTableConstraints)
    }
}
