//
//  ArticleCell.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

protocol ArticleCellDelegate {
    func didReadMoreButtonTapped(urlString: String)
    func didAuthorLabelTapped(authorsList: [String]?)
}

class ArticleCell: UICollectionViewCell {
    
    weak var articleHeading: UILabel!
    weak var readMoreButton: UIButton!
    weak var authorLabel: UILabel!
    weak var horizontalStackView: UIStackView!
    
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
        setHorizontalStackView()
    }
    
    func setArticleHeadingLabel() {
        let articleHeading = UILabel()
        articleHeading.font = UIFont.systemFont(ofSize: 15)
        articleHeading.numberOfLines = 3
        articleHeading.textColor = .black
        addSubview(articleHeading)
        self.articleHeading = articleHeading
        
        setArticleHeadingLabelConstraints()
    }
    
    func setArticleHeadingLabelConstraints() {
        articleHeading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleHeading.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            articleHeading.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            articleHeading.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    func setHorizontalStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        addSubview(stackView)
        self.horizontalStackView = stackView
        
        setHorizontalStackViewConstraints()
        setReadMoreButton()
        setAuthorLabel()
    }
    
    func setHorizontalStackViewConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
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
        horizontalStackView.addArrangedSubview(readMoreButton)
        
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        readMoreButton.setContentHuggingPriority(.required, for: .horizontal)
        
        self.readMoreButton = readMoreButton
    }
    
    func setAuthorLabel() {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 15)
        authorLabel.textColor = .link
        authorLabel.textAlignment = .right
        authorLabel.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAuthorLabel))
        authorLabel.addGestureRecognizer(gestureRecognizer)
        
        addSubview(authorLabel)
        horizontalStackView.addArrangedSubview(authorLabel)
        self.authorLabel = authorLabel
    }
    
    @objc
    func tapReadMoreButton() {
        delegate?.didReadMoreButtonTapped(urlString: readMoreUrl)
    }
    
    @objc
    func tapAuthorLabel() {
        guard let authorsListString = authorLabel.text else {
            delegate?.didAuthorLabelTapped(authorsList: nil)
            return
        }
        
        let arrayOfAuthors = authorsListString.components(separatedBy: ",")
            .map { $0.replacingOccurrences(of: "by: ", with: "") }
            .map { $0.trimmingCharacters(in: .whitespaces) }
        delegate?.didAuthorLabelTapped(authorsList: arrayOfAuthors)
    }

    func bind(with data: ArticleViewData) {
        articleHeading.text = data.articleDescription
        readMoreUrl = data.articleURL
        if let author = data.author {
            authorLabel.text = "by: \(author)"
        }
    }
}
