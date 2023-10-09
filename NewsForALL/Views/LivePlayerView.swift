//
//  LivePlayerView.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 09/10/23.
//

import UIKit
import AVKit

class LivePlayerView: UIView {

    weak var playerContainerView: UIView!
    weak var captionLabel: UILabel!
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!

    let videoId: String
    var parentViewController: UIViewController?

    init(videoId: String) {
        self.videoId = videoId
        super.init(frame: CGRectZero)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setPlayer()
        setCaptionLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPlayer() {
        let playerContainer = UIView()
        addSubview(playerContainer)
        playerContainerView = playerContainer

        // Create an AVPlayer and set its content URL
        let videoURL = URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4")
        player = AVPlayer(url: videoURL!)

        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = true

        if let parentViewController = parentViewController {

            parentViewController.addChild(playerViewController)
            playerContainerView.addSubview(playerViewController.view)
            playerViewController.didMove(toParent: parentViewController)
            playerViewController.view.frame = playerContainerView.bounds

            // Add tap gesture recognizer to play/pause
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
            playerViewController.view.addGestureRecognizer(tapGestureRecognizer)
        }

        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        playerContainerView.setContentHuggingPriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            playerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            playerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            playerContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            playerContainerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setCaptionLabel() {
        let captionLabel = UILabel()
        captionLabel.text = "Hello, I am under water. Please help me. Here too much raining. Woo oo oo oooo"
        captionLabel.font = UIFont.systemFont(ofSize: 16)
        captionLabel.numberOfLines = 0
        captionLabel.textColor = .black
        addSubview(captionLabel)
        self.captionLabel = captionLabel

        self.captionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            self.captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            self.captionLabel.topAnchor.constraint(equalTo: playerContainerView.bottomAnchor, constant: 20),
            self.captionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    // Handle tap gesture to toggle play/pause
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        if player.rate == 0 {
            player.play()
            playerViewController.showsPlaybackControls = true
        } else {
            player.pause()
            playerViewController.showsPlaybackControls = false
        }
    }
}
