//
//  LiveVideoViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 08/10/23.
//

import UIKit
import AVKit

class LiveVideoViewController: UIViewController, TabButtonsViewDelegate {

    weak var horizontalStackView: UIStackView!
    weak var channelLabel: UILabel!
    weak var channelButtonView: UIStackView!
    weak var dropdownButton: UIButton!
    weak var dropdownOptions: UIPickerView!
    weak var showButton: UIButton!
    weak var tabButtonsView: UIView!

    weak var livePlayer: LivePlayerView!

    // Options to display in the dropdown
    private let options = ["Select channel", "ABC News", "NBC News", "FOX News", "India Today"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Live"

        let navigationComponents = NavigationComponents()
        let profilebutton = navigationComponents.createProfileButton()
        profilebutton.addTarget(self, action: #selector(tapProfileButton), for: .touchUpInside)
        let profilebarButton = UIBarButtonItem(customView: profilebutton)
        navigationItem.leftBarButtonItem = profilebarButton

        setHorizontalStackView()
        setChannelLabel()
        setChannelButtonView()
        setDropdownButton()
        setShowButton()
        setPlayerView()
        setTabButtonsView()
    }

    func setHorizontalStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5

        view.addSubview(stackView)
        horizontalStackView = stackView

        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setChannelLabel() {
        let channelLabel = UILabel()
        channelLabel.text = "Channel"
        channelLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        channelLabel.textAlignment = .center
        channelLabel.textColor = .black

        horizontalStackView.addArrangedSubview(channelLabel)
        self.channelLabel = channelLabel
        
        self.channelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.channelLabel.widthAnchor.constraint(equalToConstant: view.bounds.width/3)
        ])
        
    }

    func setChannelButtonView() {
        let stackView = UIStackView()
        stackView.axis = .vertical

        horizontalStackView.addArrangedSubview(stackView)
        channelButtonView = stackView
    }

    func setDropdownButton() {
        let dropdownButton = UIButton()
        dropdownButton.setTitle(options[0], for: .normal)
        dropdownButton.setTitleColor(.black, for: .normal)
        dropdownButton.addTarget(self, action: #selector(dropdownButtonTapped), for: .touchUpInside)

        let pickerView = UIPickerView()
        pickerView.isHidden = true

        // Configure the pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        

        // Add the dropdownButton and pickerView to the button view
        channelButtonView.addArrangedSubview(dropdownButton)
        channelButtonView.addArrangedSubview(pickerView)

        self.dropdownButton = dropdownButton
        self.dropdownOptions = pickerView
    }

    func setShowButton() {
        let showButton = UIButton()
        showButton.setTitle("Show live news", for: .normal)
        showButton.addTarget(self, action: #selector(tapShowButton), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "title"
        configuration.baseBackgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        showButton.configuration = configuration
        view.addSubview(showButton)

        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setContentHuggingPriority(.required, for: .horizontal)

        self.showButton = showButton
        NSLayoutConstraint.activate([
            self.showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.showButton.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10)
        ])
    }

    func setPlayerView() {
        let livePlayerView = LivePlayerView(videoId: "Wu3sYOFxJuk")
        livePlayerView.parentViewController = self
        livePlayerView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(livePlayerView)
        livePlayer = livePlayerView
        NSLayoutConstraint.activate([
            livePlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            livePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            livePlayer.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 10)
        ])
    }

    func setTabButtonsView() {
        let buttonsView = TabButtonsView()
        buttonsView.delegate = self
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        NSLayoutConstraint.activate([
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        buttonsView.liveButton.backgroundColor = .white
        let attrString = NSAttributedString(string: "Live", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.black
        ])
        buttonsView.liveButton.setAttributedTitle(attrString, for: .normal)
        self.tabButtonsView = buttonsView
    }

    func didLiveButtonTapped() {
        // No op
    }

    func didTrendingButtonTapped() {
        let vc = NewsTrendingViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([vc], animated: false)
    }

    func didCategoriesButtonTapped() {
        let vc = NewsCategoriesViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([vc], animated: false)
    }

    @objc func tapProfileButton() {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Dropdown Handling

    @objc func dropdownButtonTapped() {
        dropdownOptions.isHidden = !dropdownOptions.isHidden
        dropdownButton.isHidden = !dropdownOptions.isHidden
    }
    
    @objc func tapShowButton() {
        print("Hello")
    }
}

extension LiveVideoViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dropdownButton.setTitle(options[row], for: .normal)
        pickerView.isHidden = true
        dropdownButton.isHidden = false
    }
}
