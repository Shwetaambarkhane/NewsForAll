//
//  NewsCategoriesViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 17/07/23.
//

import UIKit

class NewsCategoriesViewController: UIViewController, TabButtonsViewDelegate {

    weak var collectionView: UICollectionView!
    weak var tabButtonsView: UIView!
    private var categoriesData = ["Education", "Business", "Sports"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        self.navigationItem.title = "Categories"
        self.setCollectionView()
        self.setTabButtonsView()

        self.collectionView.register(NewsCategoriesCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        self.collectionView = collectionView
    }
    
    func setTabButtonsView() {
        let buttonsView = TabButtonsView()
        buttonsView.delegate = self
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsView)
        NSLayoutConstraint.activate([
            buttonsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            buttonsView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        buttonsView.categoriesButton.backgroundColor = .white
        let attrString = NSAttributedString(string: "Categories", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.black
        ])
        buttonsView.categoriesButton.setAttributedTitle(attrString, for: .normal)
        self.tabButtonsView = buttonsView
    }
    
    func didTrendingButtonTapped() {
        let vc = NewsTrendingViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didCategoriesButtonTapped() {
        // No op
    }
}

extension NewsCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

extension NewsCategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension NewsCategoriesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) as! NewsCategoriesCell
        
        let data = self.categoriesData[indexPath.row]
        cell.bind(with: data)
        return cell
    }
}
