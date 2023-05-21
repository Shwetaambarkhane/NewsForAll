//
//  ArticleCell.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    weak var articleHeading: UILabel!
    weak var readMoreButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setArticleHeadingLabel()
        setReadMoreButton()
        setArticleHeadingLabelConstraints()
        setReadMoreButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setArticleHeadingLabel() {
        let articleHeading = UILabel()
        articleHeading.font = UIFont.systemFont(ofSize: 20)
        articleHeading.textColor = UIColor.gray
        self.addSubview(articleHeading)
        self.articleHeading = articleHeading
    }
    
    func setArticleHeadingLabelConstraints() {
        self.articleHeading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.articleHeading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.articleHeading.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.articleHeading.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.articleHeading.bottomAnchor.constraint(equalTo: self.readMoreButton.topAnchor, constant: -20)
        ])
    }
    
    func setReadMoreButton() {
        let readMoreButton = UIButton()
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.backgroundColor = .systemMint
        self.addSubview(readMoreButton)
        self.readMoreButton = readMoreButton
    }
    
    func setReadMoreButtonConstraints() {
        self.readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.readMoreButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            self.readMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
//            self.readMoreButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            self.readMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func bind(with heading: String) {
        self.articleHeading.text = heading
    }
}
