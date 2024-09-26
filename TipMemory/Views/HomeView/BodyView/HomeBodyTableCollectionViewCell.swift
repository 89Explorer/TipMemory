//
//  HomeBodyTableCollectionViewCell.swift
//  TipMemory
//
//  Created by 권정근 on 9/25/24.
//

import UIKit
import SDWebImage

class HomeBodyTableCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "HomeBodyTableCollectionViewCell"
    
    // MARK: - UI Components
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "attractions")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "고양시어린이박물관"
        label.textAlignment = .center
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 14)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(basicView)
        basicView.addSubview(imageView)
        basicView.addSubview(titleLabel)
        
        contentViewSetup()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func configureConstraints() {
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            basicView.topAnchor.constraint(equalTo: contentView.topAnchor),
            basicView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ]
    
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    // MARK: - Functions
    private func contentViewSetup() {
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner,
                                           .layerMaxXMaxYCorner
        ]
        
        contentView.layer.shadowColor = UIColor.systemIndigo.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 20)
        contentView.layer.shadowRadius = 10
    }
    
    // MARK: - Functions
    func configureData(with model: Item) {
        
        guard let posterPath = model.firstimage,
              var address = model.addr1,
              var title = model.title else { return }
        
        title = (title.count != 0) ? title : "-"
        address = (address.count != 0) ? address : "-"
        
        let modifiedAddress = getAddressPrefix(fullAddress: address, wordCount: 3)
        
        let securePosterURL = posterPath.replacingOccurrences(of: "http://", with: "https://")
        
        if let url = URL(string: securePosterURL) {
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "house.fill")
        }
        
        let modifiedTitle = title.removingParentheses()
        titleLabel.text = modifiedTitle
    }
    
    // 띄어쓰기로 문자열 구분
    func getAddressPrefix(fullAddress: String, wordCount: Int) -> String {
        let components = fullAddress.split(separator: " ")  // 띄어쓰기 기준으로 문자열 분리
        let prefix = components.prefix(wordCount)          // 원하는 단어 개수만큼 가져옴
        return prefix.joined(separator: " ")               // 다시 띄어쓰기로 합침
    }
}
