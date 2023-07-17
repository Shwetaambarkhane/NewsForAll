//
//  TabButtonsView.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

protocol TabButtonsViewDelegate {
    func didTrendingButtonTapped()
    func didCategoriesButtonTapped()
}

class TabButtonsView: UIView {
    
    weak var trendingButton: UIButton!
    weak var categoriesButton: UIButton!
    var delegate: TabButtonsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTabButtons()
        self.setupTabButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabButtons() {
        let button1 = UIButton()
        let attrString1 = NSAttributedString(string: "Trending", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        button1.setAttributedTitle(attrString1, for: .normal)
        button1.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        button1.addTarget(self, action: #selector(didTrendingButtonTapped), for: .touchUpInside)
        
        let button2 = UIButton()
        let attrString2 = NSAttributedString(string: "Categories", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        button2.setAttributedTitle(attrString2, for: .normal)
        button2.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        button2.addTarget(self, action: #selector(didCategoriesButtonTapped), for: .touchUpInside)
        
        self.addSubview(button1)
        self.addSubview(button2)
        self.trendingButton = button1
        self.categoriesButton = button2
    }
    
    func setupTabButtonConstraints() {
        self.trendingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.trendingButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trendingButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            self.trendingButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.trendingButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoriesButton.leadingAnchor.constraint(equalTo: self.trendingButton.trailingAnchor),
            self.categoriesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.categoriesButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.categoriesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    @objc func didTrendingButtonTapped() {
        delegate?.didTrendingButtonTapped()
    }
    
    @objc func didCategoriesButtonTapped() {
        delegate?.didCategoriesButtonTapped()
    }
}
