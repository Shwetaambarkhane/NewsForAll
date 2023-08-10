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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        setArticleHeadingLabel()
        setReadMoreButton()
        setArticleHeadingLabelConstraints()
        setReadMoreButtonConstraints()
    }
    
    func setArticleHeadingLabel() {
        let articleHeading = UILabel()
        articleHeading.font = UIFont.systemFont(ofSize: 15)
        articleHeading.numberOfLines = 3
        articleHeading.textColor = .black
        addSubview(articleHeading)
        self.articleHeading = articleHeading
    }
    
    func setArticleHeadingLabelConstraints() {
        articleHeading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleHeading.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            articleHeading.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            articleHeading.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    func setReadMoreButton() {
        let readMoreButton = UIButton()
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.addTarget(self, action: #selector(tapReadMoreButton), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "title"
        configuration.baseBackgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        readMoreButton.configuration = configuration
        addSubview(readMoreButton)
        self.readMoreButton = readMoreButton
    }
    
    func setReadMoreButtonConstraints() {
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            readMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            readMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    @objc
    func tapReadMoreButton() {
        delegate?.didReadMoreButtonTapped(urlString: readMoreUrl)
    }

    func bind(with data: ArticleViewData) {
        articleHeading.text = data.articleDescription
        readMoreUrl = data.articleURL
    }
}
