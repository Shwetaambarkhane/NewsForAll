//
//  PublishersCell.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 30/09/23.
//

import CoreData
import Dispatch
import UIKit

class PublishersCell: UICollectionViewCell {
    
    weak var horizontalStackView: UIStackView!
    weak var nameLabel: UILabel!
    weak var subscribeButton: UIButton!
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentUsers: [CurrentUser]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchCurrentUsers()
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
        horizontalStackView.addArrangedSubview(subscribeButton)
        
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.setContentHuggingPriority(.required, for: .horizontal)
        
        self.subscribeButton = subscribeButton
    }
    
    func updateButton() {
        let isSubscribedPublisher = isSubscribed()
        let buttonTitle = isSubscribedPublisher ? "Subscribed" : "Subscribe"
        subscribeButton.setTitle(buttonTitle, for: .normal)
        subscribeButton.addTarget(self, action: #selector(tapSubscribeButton), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "title"
        configuration.baseBackgroundColor = isSubscribedPublisher ? .gray : UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        subscribeButton.configuration = configuration
    }
    
    func isSubscribed() -> Bool {
        guard let currentUsers = currentUsers else {
            return false
        }
        let currentUser = currentUsers.first!
        
        guard let name = nameLabel.text else {
            print("No Publisher found to subscribe")
            return false
        }
        
        var isSubscribedPublisher = false
        currentUser.subscribePublishers?.forEach {
            if ($0 as! SubscribePublisher).publisherName == name {
                isSubscribedPublisher = true
            }
        }
        
        return isSubscribedPublisher
    }
    
    @objc
    func tapSubscribeButton() {
        guard let currentUsers = currentUsers else {
            return
        }
        let currentUser = currentUsers.first!
        
        guard let name = nameLabel.text else {
            print("No Publisher found to subscribe")
            return
        }
        
        if isSubscribed() {
            if let valueToDelete = currentUser.subscribePublishers?.first(where: { ($0 as! SubscribePublisher).publisherName == name }) as? SubscribePublisher {
                currentUser.removeFromSubscribePublishers(valueToDelete)
                
                // save context
                do {
                    try context.save()
                } catch {
                    print("Unsuccessful save request")
                }
            }
            
            do {
                let subscription = try context.fetch(SubscribePublisher.fetchRequest())
                context.delete(subscription[0])
            } catch {
                print("Unsuccessful SubscribePublisher fetch request")
            }
            
            // save context
            do {
                try context.save()
            } catch {
                print("Unsuccessful save request")
            }
            
            updateButton()
            return
        }
        
        // create new subscription
        let newSubscription = SubscribePublisher(context: context)
        newSubscription.publisherName = name
        
        var subscribedPublishers: NSMutableSet
        if currentUser.subscribePublishers == nil || currentUser.subscribePublishers?.count == 0 {
            subscribedPublishers = NSMutableSet()
        } else {
            subscribedPublishers = NSMutableSet(set: currentUser.subscribePublishers!)
        }
        subscribedPublishers.add(newSubscription)
        currentUser.subscribePublishers = subscribedPublishers
        
        // save context
        do {
            try context.save()
        } catch {
            print("Unsuccessful save request")
        }
        
        updateButton()
    }
    
    func bind(with name: String) {
        nameLabel.text = name
        updateButton()
    }
    
    func fetchCurrentUsers() {
        do {
            currentUsers = try context.fetch(CurrentUser.fetchRequest())
        } catch {
            print("Unsuccessful current user fetch request")
        }
    }
}
