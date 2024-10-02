//
//  HomeHeaderView.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

class HomeHeaderView: UIView {
    
    // MARK: - UI Components
    let headerBasicView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner,
                                    .layerMaxXMaxYCorner]  // 좌, 우 하단 적용
        view.layer.shadowColor = UIColor.systemIndigo.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 15
        
        // view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        // 선택적으로 그림자 경로를 설정하여 성능 최적화
        return view
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Sarah"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 28)
        // label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    let alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재 위치: 인천 서구 가정동"
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 18)
        label.textColor = .label
        return label
    }()
    
    let checkLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location.magnifyingglass"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let categoryView: CategoryView = {
        let view = CategoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(headerBasicView)
        headerBasicView.addSubview(titleLabel)
        headerBasicView.addSubview(alarmButton)
        headerBasicView.addSubview(locationLabel)
        headerBasicView.addSubview(checkLocationButton)
        headerBasicView.addSubview(categoryView)
        
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
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: headerBasicView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: headerBasicView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: headerBasicView.topAnchor, constant: 80)
        ]
        
        let alarmButtonConstraints = [
            alarmButton.trailingAnchor.constraint(equalTo: headerBasicView.trailingAnchor, constant: -30),
            alarmButton.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        ]
        
        let locationLabelConstraints = [
            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 3),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ]
        
        let checkLocationButtonConstraints = [
            checkLocationButton.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 8),
            checkLocationButton.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            checkLocationButton.heightAnchor.constraint(equalToConstant: 18),
            checkLocationButton.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let categoryViewConstraints = [
            categoryView.leadingAnchor.constraint(equalTo: headerBasicView.leadingAnchor, constant: 15),
            categoryView.trailingAnchor.constraint(equalTo: headerBasicView.trailingAnchor, constant: -15),
            categoryView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            categoryView.heightAnchor.constraint(equalToConstant: 250),
//            categoryView.bottomAnchor.constraint(equalTo: headerBasicView.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(headerBasicViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(alarmButtonConstraints)
        NSLayoutConstraint.activate(locationLabelConstraints)
        NSLayoutConstraint.activate(checkLocationButtonConstraints)
        NSLayoutConstraint.activate(categoryViewConstraints)
    }
}
