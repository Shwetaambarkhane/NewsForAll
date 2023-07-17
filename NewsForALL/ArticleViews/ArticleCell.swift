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
        articleHeading.numberOfLines = 3
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
        readMoreButton.addTarget(self, action: #selector(tapReadMoreButton), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "title"
        configuration.baseBackgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        readMoreButton.configuration = configuration
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
    
    func cellHeight() -> CGFloat {
        let textHeight: CGFloat
        if let text = self.articleHeading.text {
            textHeight = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 32, font: self.articleHeading.font)
        } else {
            textHeight = "a\na\na\na".height(withConstrainedWidth: UIScreen.main.bounds.width - 32, font: self.articleHeading.font)
        }
        let buttonHeight = self.readMoreButton.frame.size.height
        return textHeight + buttonHeight + 40 + 16 + 10
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 15)], context: nil)
        return ceil(boundingBox.height)
        
    }
}
