//
//  DetailImageCollectionViewCell.swift
//  TipMemory
//
//  Created by 권정근 on 9/29/24.
//

import UIKit
import SDWebImage

class DetailImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier: String = "DetailImageCollectionViewCell"
    
    
    // MARK: - UI Components
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "attractions")
        return imageView
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(basicView)
        basicView.addSubview(imageView)
        
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
        
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: basicView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: 300),
            // imageView.widthAnchor.constraint(equalTo: basicView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    
    // MARK: - Functions
    func configureImage(with imageURL: String) {
        
        let securePosterURL = imageURL.replacingOccurrences(of: "http://", with: "https://")
        
        if let url = URL(string: securePosterURL) {
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "house.fill")
        }
    }
}
