//
//  AuthorsCell.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 30/09/23.
//

import UIKit

class AuthorsCell: UICollectionViewCell {
    
    weak var horizontalStackView: UIStackView!
    weak var nameLabel: UILabel!
    weak var subscribeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHorizontalStackView()
        setNameLabel()
        setSubscribeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHorizontalStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        addSubview(stackView)
        horizontalStackView = stackView
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func setNameLabel() {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.numberOfLines = 3
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        
        horizontalStackView.addArrangedSubview(nameLabel)
        self.nameLabel = nameLabel
    }
    
    func setSubscribeButton() {
        let subscribeButton = UIButton()
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.addTarget(self, action: #selector(tapSubscribeButton), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "title"
        configuration.baseBackgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        subscribeButton.configuration = configuration
        horizontalStackView.addArrangedSubview(subscribeButton)
        
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.setContentHuggingPriority(.required, for: .horizontal)
        
        self.subscribeButton = subscribeButton
    }
    
    @objc
    func tapSubscribeButton() {
        print("temp text")
    }
    
    func bind(with name: String) {
        nameLabel.text = name
    }
}
