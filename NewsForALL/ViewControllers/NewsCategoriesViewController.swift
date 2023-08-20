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
    private var categoriesData = ["Business", "Sports", "Entertainment", "Technology", "Science"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Categories"
        setCollectionView()
        setTabButtonsView()

        collectionView.register(NewsCategoriesCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        self.collectionView = collectionView
    }
    
    func setTabButtonsView() {
        let buttonsView = TabButtonsView()
        buttonsView.delegate = self
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        NSLayoutConstraint.activate([
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didCategoriesButtonTapped() {
        // No op
    }
    
    func didCellTapped(withCategory category: String) {
        let vc = NewsOfCategoryViewController(category: category)
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didCellTapped(withCategory: categoriesData[indexPath.row])
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
            withReuseIdentifier: "categoryCell",
            for: indexPath) as! NewsCategoriesCell
        
        let data = categoriesData[indexPath.row]
        cell.bind(with: data)
        return cell
    }
}
