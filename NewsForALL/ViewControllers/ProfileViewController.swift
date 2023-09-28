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
    
    // Data for the list of names
    let names = ["John", "Alice", "Bob", "Eva", "Charlie"]
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentUsers: [CurrentUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        fetchCurrentUsers()
        
        setProfileImage()
        setProfileNameLabel()
        setLogoutButton()
        
        // Set the collection view's delegate and data source
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        
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
            
//            // Collection View
//            collectionView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Logout Button
            logoutButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
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

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameCell", for: indexPath) as! NameCollectionViewCell
        cell.nameLabel.text = names[indexPath.item]
        return cell
    }
    
    // Set the size of collection view cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // You can customize the cell size here
        return CGSize(width: 100, height: 100)
    }
}

class NameCollectionViewCell: UICollectionViewCell {
    weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textColor = .black
        addSubview(nameLabel)
        self.nameLabel = nameLabel
    }
}
