//
//  TabButtonsView.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

protocol TabButtonsViewDelegate {
    func didButtonTapped()
}

class TabButtonsView: UIView {
    
    weak var tab1Button: UIButton!
    weak var tab2Button: UIButton!
    var delegate: TabButtonsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTabButtons()
        self.setupTabButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("hello")
    }
    
    func setupTabButtons() {
        let button1 = UIButton()
        button1.setTitle("TabVCButton1", for: .normal)
        button1.backgroundColor = .lightGray
        button1.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        
        let button2 = UIButton()
        button2.setTitle("TabVCButton2", for: .normal)
        button2.backgroundColor = .lightGray
        button2.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        
        self.addSubview(button1)
        self.addSubview(button2)
        self.tab1Button = button1
        self.tab2Button = button2
    }
    
    func setupTabButtonConstraints() {
        self.tab1Button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tab1Button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tab1Button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            self.tab1Button.topAnchor.constraint(equalTo: self.topAnchor),
            self.tab1Button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.tab2Button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tab2Button.leadingAnchor.constraint(equalTo: self.tab1Button.trailingAnchor),
            self.tab2Button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tab2Button.topAnchor.constraint(equalTo: self.topAnchor),
            self.tab2Button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func didButtonTapped() {
        delegate?.didButtonTapped()
    }
}
