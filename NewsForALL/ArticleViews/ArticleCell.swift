//
//  ArticleCell.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

protocol ArticleCellDelegate {
    func didReadMoreButtonTapped(urlString: String)
}

class ArticleCell: UICollectionViewCell {
    
    weak var articleHeading: UILabel!
    weak var readMoreButton: UIButton!
    var readMoreUrl: String!
    var delegate: ArticleCellDelegate?
    
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
        setArticleHeadingLabel()
        setReadMoreButton()
        setArticleHeadingLabelConstraints()
        setReadMoreButtonConstraints()
    }
    
    func setArticleHeadingLabel() {
        let articleHeading = UILabel()
        articleHeading.font = UIFont.systemFont(ofSize: 15)
        articleHeading.numberOfLines = 2
        articleHeading.textColor = .black
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
        readMoreButton.backgroundColor = .gray
        readMoreButton.addTarget(self, action: #selector(tapReadMoreButton), for: .touchUpInside)
        self.addSubview(readMoreButton)
        self.readMoreButton = readMoreButton
    }
    
    func setReadMoreButtonConstraints() {
        self.readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.readMoreButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.readMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    @objc
    func tapReadMoreButton() {
        delegate?.didReadMoreButtonTapped(urlString: self.readMoreUrl)
    }

    func bind(with data: ArticleViewData) {
        self.articleHeading.text = data.articleDescription
        self.readMoreUrl = data.articleURL
    }
}
