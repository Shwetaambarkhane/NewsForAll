//
//  PublishersBottomsheetController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 29/09/23.
//

import UIKit

class PublishersBottomsheetController: UIViewController {
    
    weak var titleLabel: UILabel!
    weak var collectionView: UICollectionView!
    
    var publishersList: [String]?
    
    init(publishersList: [String]?) {
        self.publishersList = publishersList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setTitleLabel()
        setCollectionView()
        
        collectionView.register(PublishersCell.self, forCellWithReuseIdentifier: "publisherCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Publishers"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        self.titleLabel = titleLabel
    }
    
    func setCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        self.collectionView = collectionView
    }

}

extension PublishersBottomsheetController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
    }
}

extension PublishersBottomsheetController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 20, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension PublishersBottomsheetController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let publishersList = publishersList else {
            print("No data")
            return 0
        }
        return publishersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "publisherCell",
            for: indexPath) as! PublishersCell
        
        guard let data = publishersList else {
            print("No data")
            return UICollectionViewCell()
        }
        
        let name = data[indexPath.row]
        cell.bind(with: name)
        return cell
    }

}
