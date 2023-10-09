//
//  TabButtonsView.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

protocol TabButtonsViewDelegate {
    func didLiveButtonTapped()
    func didTrendingButtonTapped()
    func didCategoriesButtonTapped()
}

class TabButtonsView: UIView {
    
    weak var liveButton: UIButton!
    weak var trendingButton: UIButton!
    weak var categoriesButton: UIButton!
    var delegate: TabButtonsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLiveButton()
        setTrendingButton()
        setCategoriesButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLiveButton() {
        let button = UIButton()
        let attrString1 = NSAttributedString(string: "Live", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        button.setAttributedTitle(attrString1, for: .normal)
        button.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        button.addTarget(self, action: #selector(didLiveButtonTapped), for: .touchUpInside)
        
        addSubview(button)
        liveButton = button
        
        liveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            liveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            liveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            liveButton.topAnchor.constraint(equalTo: topAnchor),
            liveButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setTrendingButton() {
        let button = UIButton()
        let attrString1 = NSAttributedString(string: "Trending", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        button.setAttributedTitle(attrString1, for: .normal)
        button.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        button.addTarget(self, action: #selector(didTrendingButtonTapped), for: .touchUpInside)
        
        addSubview(button)
        trendingButton = button
        
        trendingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingButton.leadingAnchor.constraint(equalTo: liveButton.trailingAnchor),
            trendingButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            trendingButton.topAnchor.constraint(equalTo: topAnchor),
            trendingButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setCategoriesButton() {
        let button = UIButton()
        let attrString1 = NSAttributedString(string: "Trending", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.white
        ])
        button.setAttributedTitle(attrString1, for: .normal)
        button.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        button.addTarget(self, action: #selector(didCategoriesButtonTapped), for: .touchUpInside)
        
        addSubview(button)
        categoriesButton = button
        
        categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriesButton.leadingAnchor.constraint(equalTo: trendingButton.trailingAnchor),
            categoriesButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesButton.topAnchor.constraint(equalTo: topAnchor),
            categoriesButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func didLiveButtonTapped() {
        delegate?.didLiveButtonTapped()
    }

    @objc func didTrendingButtonTapped() {
        delegate?.didTrendingButtonTapped()
    }
    
    @objc func didCategoriesButtonTapped() {
        delegate?.didCategoriesButtonTapped()
    }
}
