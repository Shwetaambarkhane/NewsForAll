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
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        setCategoryLabel()
        setCategoryImage()
        setCategoryLabelConstraints()
        setCategoryImageConstraints()
//        self.frame = CGRect(x: 0, y: 0, width: self.categoryImage.frame.width, height: self.categoryImage.frame.height)
    }
    
    func setCellConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.heightAnchor.constraint(equalTo: self.categoryImage.heightAnchor, constant: 20)
        ])
    }
    
    func setCategoryLabel() {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 18)
        categoryLabel.textColor = .black
        self.addSubview(categoryLabel)
        self.categoryLabel = categoryLabel
    }
    
    func setCategoryLabelConstraints() {
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.categoryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.categoryImage.trailingAnchor),
            self.categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setCategoryImage() {
        let image = UIImage(named: "Education")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        self.categoryImage = imageView
    }
    
    func setCategoryImageConstraints() {
        self.categoryImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.categoryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.categoryImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.categoryImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func bind(with category: String) {
        self.categoryLabel.text = category
        self.categoryImage.image = UIImage(named: category)
    }

}
