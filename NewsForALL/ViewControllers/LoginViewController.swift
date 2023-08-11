//
//  LoginViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 07/08/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    weak var titleLabel: UILabel!
    weak var emailId: UITextField!
    weak var password: UITextField!
    weak var confirmPassword: UITextField!
    weak var messageLabel: UILabel!
    weak var loginButton: UIButton!
    weak var signUpLabel: UILabel!
    weak var componentStackView: UIStackView!
    
    var haveAccount = true
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var registeredUser: [RegisteredUser]?
    var currentUsers: [CurrentUser]?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
        fetchRegisteredUsers()
        fetchCurrentUsers()
    }
    
    func fetchRegisteredUsers() {
        do {
            registeredUser = try context.fetch(RegisteredUser.fetchRequest())
        } catch {
            print("Unsuccessful registered users fetch request")
        }
    }
    
    func fetchCurrentUsers() {
        do {
            currentUsers = try context.fetch(CurrentUser.fetchRequest())
        } catch {
            print("Unsuccessful current user fetch request")
        }
    }
    
    func setupViews() {
        setTitleLabel()
        setTitleLabelConstraints()
        setComponentStackView()
        setComponentStackViewConstraints()
        setEmailIdField()
        setEmailIdFieldConstraints()
        setPasswordField()
        setPasswordFieldConstraints()
        if !haveAccount {
            setConfirmPasswordField()
            setConfirmPasswordFieldConstraints()
        }
        setMessageLabel()
        setMessageLabelConstraints()
        setLoginButton()
        setLoginButtonConstraints()
        setSignupLabel()
        setSignupLabelConstraints()
    }
    
    func setTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = haveAccount ? "Log in" : "Create new account"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .blue
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    func setComponentStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        view.addSubview(stackView)
        self.componentStackView = stackView
    }
    
    func setComponentStackViewConstraints() {
        componentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            componentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            componentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            componentStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            componentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setEmailIdField() {
        let emailId = UITextField()
        emailId.placeholder = "Enter email id"
        emailId.font = UIFont.systemFont(ofSize: 18)
        emailId.borderStyle = UITextField.BorderStyle.roundedRect
        emailId.autocorrectionType = .no
        emailId.autocapitalizationType = .none
        
        componentStackView.addArrangedSubview(emailId)
        self.emailId = emailId
    }
    
    func setEmailIdFieldConstraints() {
        emailId.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailId.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setPasswordField() {
        let password = UITextField()
        password.placeholder = "Enter password"
        password.font = UIFont.systemFont(ofSize: 18)
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.autocorrectionType = .no
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        
        componentStackView.addArrangedSubview(password)
        self.password = password
    }
    
    func setPasswordFieldConstraints() {
        password.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            password.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setConfirmPasswordField() {
        let password = UITextField()
        password.placeholder = "Confirm password"
        password.font = UIFont.systemFont(ofSize: 18)
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.autocorrectionType = .no
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        
        componentStackView.addArrangedSubview(password)
        self.confirmPassword = password
    }
    
    func setConfirmPasswordFieldConstraints() {
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmPassword.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setMessageLabel() {
        let messageLabel = UILabel()
        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.textColor = .red
        messageLabel.isHidden = true
        
        componentStackView.addArrangedSubview(messageLabel)
        self.messageLabel = messageLabel
    }
    
    func setMessageLabelConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setLoginButton() {
        let loginButton = UIButton()
        let title = haveAccount ? "Log in" : "Sign up"
        let attrTitle = NSAttributedString(string: title, attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.white
        ])
        loginButton.setAttributedTitle(attrTitle, for: .normal)
        loginButton.addTarget(self, action: #selector(didLoginButtonTapped), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "title"
        configuration.baseBackgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        loginButton.configuration = configuration
        
        componentStackView.addArrangedSubview(loginButton)
        self.loginButton = loginButton
    }
    
    func setLoginButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setSignupLabel() {
        let signupLabel = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(refreshPage))
        let text = haveAccount ? "Not have an account ? Sign up" : "Already have account ? Log in"
        signupLabel.text = text
        signupLabel.font = .systemFont(ofSize: 15)
        signupLabel.textColor = .blue
        signupLabel.isUserInteractionEnabled = true
        signupLabel.addGestureRecognizer(tapGesture)
        
        componentStackView.addArrangedSubview(signupLabel)
        self.signUpLabel = signupLabel
    }
    
    func setSignupLabelConstraints() {
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    func didLoginButtonTapped() {
        showErrorMessage()
        
        if messageLabel.text != nil {
            return
        }
        
        if haveAccount {
            setCurrentUser()
            
            let vc = NewsTrendingViewController()
            vc.modalPresentationStyle = .fullScreen
            navigationController?.popViewController(animated: false)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
            addToRegisteredUsers()
            refreshPage()
        }
    }
    
    func showErrorMessage() {
        if emailId.text == "" {
            messageLabel.text = "Email id cannot be empty"
        } else if password.text == "" {
            messageLabel.text = "Password cannot be empty"
        } else if !haveAccount && (password.text != confirmPassword.text) {
            messageLabel.text = "Passwords don't match"
        } else {
            var isError = false
            var isRegistered = false
            
            registeredUser?.forEach { rUser in
                if emailId.text == rUser.user?.emailId {
                    if !haveAccount {
                        messageLabel.text = "This email id is already registered, login"
                        isError = true
                    } else {
                        isRegistered = true
                        if password.text != rUser.user?.password {
                            messageLabel.text = "Wrong password"
                            isError = true
                        }
                    }
                }
            }
            
            if haveAccount && !isRegistered {
                messageLabel.text = "This email id is not registered, sign up"
                isError = true
            }
            if !isError {
                messageLabel.text = nil
                return
            }
        }
        
        messageLabel.isHidden = false
        view.layoutIfNeeded()
    }
    
    func setCurrentUser() {
        
        if currentUsers != nil && currentUsers!.count > 0 {
            context.delete(currentUsers![0])
        }
        
        // create new user
        let user = User(context: context)
        user.emailId = emailId.text
        user.password = password.text
        
        let currentUser = CurrentUser(context: context)
        currentUser.user = user
        
        // save context
        do {
            try context.save()
        } catch {
            print("Unsuccessful save request")
        }
        
        // fetch data
        fetchCurrentUsers()
    }
    
    func addToRegisteredUsers() {
        
        // create new user
        let newUser = User(context: context)
        newUser.emailId = emailId.text
        newUser.password = password.text
        
        let newRegisteredUser = RegisteredUser(context: context)
        newRegisteredUser.user = newUser
        
        // save context
        do {
            try context.save()
        } catch {
            print("Unsuccessful save request")
        }
        
        // fetch data
        fetchRegisteredUsers()
    }
    
    @objc
    func refreshPage() {
        haveAccount = !haveAccount
        
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
}
