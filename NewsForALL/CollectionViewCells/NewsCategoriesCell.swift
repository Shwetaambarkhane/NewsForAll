//
//  NewsCategoriesCell.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 20/07/23.
//

import UIKit

class NewsCategoriesCell: UICollectionViewCell {
    
    weak var categoryImage: UIImageView!
    weak var categoryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        setCategoryLabel()
        setCategoryImage()
        setCategoryLabelConstraints()
        setCategoryImageConstraints()
    }
    
    func setCellConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: categoryImage.heightAnchor, constant: 20)
        ])
    }
    
    func setCategoryLabel() {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 18)
        categoryLabel.textColor = .black
        addSubview(categoryLabel)
        self.categoryLabel = categoryLabel
    }
    
    func setCategoryLabelConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categoryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: categoryImage.trailingAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setCategoryImage() {
        let image = UIImage(named: "Education")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        self.categoryImage = imageView
    }
    
    func setCategoryImageConstraints() {
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            categoryImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func bind(with category: String) {
        categoryLabel.text = category
        categoryImage.image = UIImage(named: category)
    }

}
