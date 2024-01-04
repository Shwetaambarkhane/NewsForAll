//
//  ProfileViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 27/09/23.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Views
    weak var profileImageView: UIImageView!
    weak var profileNameLabel: UILabel!
    weak var logoutButton: UIButton!
    weak var collectionView: UICollectionView!
    weak var dividerView: UIView!
    
    // Data for the list of names
    var names = [String]()
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentUsers: [CurrentUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        fetchCurrentUsers()
        getSubscribedPublishersList()
        
        setProfileImage()
        setProfileNameLabel()
        setDividerView()
        setCollectionView()
        setLogoutButton()
        
        // Set the collection view's delegate and data source
        collectionView.register(PublishersCell.self, forCellWithReuseIdentifier: "publisherCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerReuseIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Set up Auto Layout constraints
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Profile Image View
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Profile Name Label
            profileNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            
            // Logout Button
            logoutButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.heightAnchor.constraint(equalToConstant: collectionView.contentSize.height).isActive = true
    }
    
    func getSubscribedPublishersList() {
        guard let currentUsers = currentUsers else {
            return
        }
        let currentUser = currentUsers.first!
        
        currentUser.subscribePublishers?.forEach {
            let name = ($0 as! SubscribePublisher).publisherName
            guard let name = name else {
                return
            }
            names.append(name)
        }
    }
    
    func setProfileImage() {
        let image = UIImage(systemName: "person.circle")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        self.profileImageView = imageView
    }
    
    func setProfileNameLabel() {
        let profileNameLabel = UILabel()
        profileNameLabel.text = "User"
        profileNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        profileNameLabel.numberOfLines = 3
        profileNameLabel.textColor = .black
        
        view.addSubview(profileNameLabel)
        self.profileNameLabel = profileNameLabel
    }
    
    func setDividerView() {
        let divider = UIView()
        divider.backgroundColor = .black
        divider.alpha = 0.2
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(divider)
        dividerView = divider

        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10)
        ])
        self.collectionView = collectionView
    }
    
    func setLogoutButton() {
        let logoutButton = UIButton()
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        self.logoutButton = logoutButton
    }
    
    @objc
    func tapLogoutButton() {
        if currentUsers != nil && currentUsers!.count > 0 {
            context.delete(currentUsers![0])
        }
        
        // save context
        do {
            try context.save()
        } catch {
            print("Unsuccessful save request")
        }
        
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.dismiss(animated: false)
        present(vc, animated: true)
    }
    
    func fetchCurrentUsers() {
        do {
            currentUsers = try context.fetch(CurrentUser.fetchRequest())
        } catch {
            print("Unsuccessful current user fetch request")
        }
    }

}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 20, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerReuseIdentifier", for: indexPath)
            
            let titleLabel = UILabel()
            if names.count < 1 {
                titleLabel.text = "No Publishers Subscribed"
            } else {
                titleLabel.text = "Subscribed Publishers"
            }
            titleLabel.textColor = .black
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabel.frame = CGRect(x: 10, y: 0, width: collectionView.frame.size.width - 20, height: 30)
            headerView.addSubview(titleLabel)
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the desired size for the header view
        return CGSize(width: collectionView.bounds.width, height: 30)
    }

}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "publisherCell",
            for: indexPath) as! PublishersCell
        
        let name = names[indexPath.row]
        cell.bind(with: name)
        return cell
    }
}
