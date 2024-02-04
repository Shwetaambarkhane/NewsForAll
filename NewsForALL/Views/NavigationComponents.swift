//
//  NavigationComponents.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 28/09/23.
//

import UIKit

class NavigationComponents {
    
    func createProfileButton() -> UIButton {
        let profileImage = UIImage(systemName: "person.circle")
        let profilebutton = UIButton(type: .custom)
        profilebutton.contentVerticalAlignment = .fill
        profilebutton.contentHorizontalAlignment = .fill
        profilebutton.setImage(profileImage, for: .normal)
        profilebutton.tintColor = .black
        
        profilebutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilebutton.heightAnchor.constraint(equalToConstant: 30),
            profilebutton.widthAnchor.constraint(equalToConstant: 30)
        ])
        return profilebutton
    }

}
