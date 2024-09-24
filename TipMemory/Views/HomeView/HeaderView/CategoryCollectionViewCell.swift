//
//  CategoryCollectionViewCell.swift
//  TipMemory
//
//  Created by 권정근 on 9/24/24.
//


import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "CategoryCollectionViewCell"
    
    // MARK: - UI Components
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill // 비율 유지
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "문화시설"
        label.textAlignment = .center
        label.font = UIFont(name: "HakgyoansimBunpilR", size: 14)
        label.textColor = .label
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.isHidden = true
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(basicView)
        basicView.addSubview(categoryImage)
        basicView.addSubview(categoryLabel)
        basicView.addSubview(underLine)
        
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
        
        let categoryImageConstraints = [
            categoryImage.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 5),
            categoryImage.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -5),
            categoryImage.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 5),
            categoryImage.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let categoryLabelConstraints = [
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 5)
        ]
        
        let underLineConstraints = [
            underLine.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor, constant: 2),
            underLine.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: -2),
            underLine.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 3),
            underLine.heightAnchor.constraint(equalToConstant: 3)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(categoryImageConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(underLineConstraints)

    }
    
    // MARK: - Functions
    func configureCategory(title: String, isSelected: Bool, image: String) {
        categoryLabel.text = title
        categoryImage.image = UIImage(named: image)
        underLine.isHidden = !isSelected
        categoryLabel.textColor = isSelected ? .systemRed : .label
    }
}

//import UIKit
//
//class CategoryCollectionViewCell: UICollectionViewCell {
//    
//    // MARK: - Variables
//    static let identifier = "CategoryCollectionViewCell"
//    
//    // MARK: - UI Components
//    let basicView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let categoryStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .fill
//        stackView.spacing = 8
//        return stackView
//    }()
//    
//    let categoryImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "mountain.2.circle")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 5
//        imageView.tintColor = .black
//        return imageView
//    }()
//    
//    let categoryLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "문화시설"
//        label.font = UIFont(name: "HakgyoansimBunpilR", size: 14)
//        label.textColor = .label
//        return label
//    }()
//    
//    let underLine: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemRed
//        view.isHidden = true
//        return view
//    }()
//    
//    
//    // MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(basicView)
//        basicView.addSubview(categoryStackView)
//        categoryStackView.addArrangedSubview(categoryImage)
//        categoryStackView.addArrangedSubview(categoryLabel)
//        categoryStackView.addArrangedSubview(underLine)
//        
//        configureConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Layouts
//    private func configureConstraints() {
//        
//        let basicViewConstraints = [
//            basicView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            basicView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            basicView.topAnchor.constraint(equalTo: topAnchor),
//            basicView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ]
//        
//        let categoryStackView = [
//            categoryStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor,constant: 3),
//            categoryStackView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -3),
//            categoryStackView.topAnchor.constraint(equalTo: basicView.topAnchor,constant: 3),
//            categoryStackView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor,constant: -3)
//        ]
//        
//        NSLayoutConstraint.activate(basicViewConstraints)
//        NSLayoutConstraint.activate(categoryStackView)
//    }
//    
//    // MARK: - Functions
//    func configureCategory(title: String, isSelected: Bool, image: String) {
//        categoryLabel.text = title
//        categoryImage.image = UIImage(named: image)
//        underLine.isHidden = !isSelected
//        if isSelected == true {
//            categoryLabel.textColor = .systemRed
//        } else {
//            categoryLabel.textColor = .label
//        }
//    }
//}
