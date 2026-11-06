//
//  AudioViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 05.11.2026.
//

import AVFoundation
import Foundation
import UIKit

class AudioViewController: UIViewController {
    private func imageWithAlpha(_ image: UIImage, alpha: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        return renderer.image { _ in image.draw(at: .zero, blendMode: .normal, alpha: alpha)
        }
    }

    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.clipsToBounds = true
        playButton.layer.cornerRadius = 20

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return playButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        playButton.setBackgroundImage(bluePixel, for: .normal)
        playButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        playButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        playButton.setBackgroundImage(dimmedBluePixel, for: .disabled)

        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)

        return playButton
    }()

    private lazy var playImageViewEmpty: UIImageView = {
        let playImageViewEmpty = UIImageView()
        playImageViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        playImageViewEmpty.image = UIImage(systemName: "play")
        playImageViewEmpty.isHidden = false
        playImageViewEmpty.backgroundColor = .clear
        playImageViewEmpty.tintColor = .white

        return playImageViewEmpty
    }()

    private lazy var playImageViewFilled: UIImageView = {
        let playImageViewFilled = UIImageView()
        playImageViewFilled.translatesAutoresizingMaskIntoConstraints = false
        playImageViewFilled.image = UIImage(systemName: "play.fill")
        playImageViewFilled.isHidden = true
        playImageViewFilled.backgroundColor = .clear
        playImageViewFilled.tintColor = .white

        return playImageViewFilled
    }()

    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.clipsToBounds = true
        pauseButton.layer.cornerRadius = 20

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return pauseButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        pauseButton.setBackgroundImage(bluePixel, for: .normal)
        pauseButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        pauseButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        pauseButton.setBackgroundImage(dimmedBluePixel, for: .disabled)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)

        return pauseButton
    }()

    private lazy var pauseImageViewEmpty: UIImageView = {
        let pauseImageViewEmpty = UIImageView()
        pauseImageViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        pauseImageViewEmpty.image = UIImage(systemName: "pause")
        pauseImageViewEmpty.backgroundColor = .clear
        pauseImageViewEmpty.isHidden = false
        pauseImageViewEmpty.tintColor = .white

        return pauseImageViewEmpty
    }()

    private lazy var pauseImageViewFilled: UIImageView = {
        let pauseImageViewFilled = UIImageView()
        pauseImageViewFilled.translatesAutoresizingMaskIntoConstraints = false
        pauseImageViewFilled.image = UIImage(systemName: "pause.fill")
        pauseImageViewFilled.backgroundColor = .clear
        pauseImageViewFilled.isHidden = true
        pauseImageViewFilled.tintColor = .white

        return pauseImageViewFilled
    }()

    private lazy var stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.clipsToBounds = true
        stopButton.layer.cornerRadius = 20

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return stopButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        stopButton.setBackgroundImage(bluePixel, for: .normal)
        stopButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        stopButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        stopButton.setBackgroundImage(dimmedBluePixel, for: .disabled)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)

        return stopButton
    }()

    private lazy var stopImageViewEmpty: UIImageView = {
        let stopImageViewEmpty = UIImageView()
        stopImageViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        stopImageViewEmpty.image = UIImage(systemName: "stop")
        stopImageViewEmpty.isHidden = false
        stopImageViewEmpty.backgroundColor = .clear
        stopImageViewEmpty.tintColor = .white

        return stopImageViewEmpty
    }()

    private lazy var stopImageViewFilled: UIImageView = {
        let stopImageViewFilled = UIImageView()
        stopImageViewFilled.translatesAutoresizingMaskIntoConstraints = false
        stopImageViewFilled.image = UIImage(systemName: "stop.fill")
        stopImageViewFilled.isHidden = true
        stopImageViewFilled.backgroundColor = .clear
        stopImageViewFilled.tintColor = .white

        return stopImageViewFilled
    }()

    func setupView() {
        view.backgroundColor = .systemGray
    }

    func addSubviews() {
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(stopButton)
        playButton.addSubview(playImageViewEmpty)
        playButton.addSubview(playImageViewFilled)
        pauseButton.addSubview(pauseImageViewEmpty)
        pauseButton.addSubview(pauseImageViewFilled)
        stopButton.addSubview(stopImageViewEmpty)
        stopButton.addSubview(stopImageViewFilled)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),

            playImageViewEmpty.widthAnchor.constraint(equalToConstant: 30),
            playImageViewEmpty.heightAnchor.constraint(equalTo: playImageViewEmpty.widthAnchor),
            playImageViewEmpty.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            playImageViewEmpty.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),

            playImageViewFilled.widthAnchor.constraint(equalToConstant: 30),
            playImageViewFilled.heightAnchor.constraint(equalTo: playImageViewEmpty.widthAnchor),
            playImageViewFilled.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            playImageViewFilled.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),

            pauseButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            pauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pauseButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            pauseButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),

            pauseImageViewEmpty.widthAnchor.constraint(equalToConstant: 30),
            pauseImageViewEmpty.heightAnchor.constraint(equalTo: pauseImageViewEmpty.widthAnchor),
            pauseImageViewEmpty.centerXAnchor.constraint(equalTo: pauseButton.centerXAnchor),
            pauseImageViewEmpty.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),

            pauseImageViewFilled.widthAnchor.constraint(equalToConstant: 30),
            pauseImageViewFilled.heightAnchor.constraint(equalTo: pauseImageViewFilled.widthAnchor),
            pauseImageViewFilled.centerXAnchor.constraint(equalTo: pauseButton.centerXAnchor),
            pauseImageViewFilled.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),

            stopButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 20),
            stopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stopButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            stopButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),

            stopImageViewEmpty.widthAnchor.constraint(equalToConstant: 30),
            stopImageViewEmpty.heightAnchor.constraint(equalTo: stopImageViewEmpty.widthAnchor),
            stopImageViewEmpty.centerXAnchor.constraint(equalTo: stopButton.centerXAnchor),
            stopImageViewEmpty.centerYAnchor.constraint(equalTo: stopButton.centerYAnchor),

            stopImageViewFilled.widthAnchor.constraint(equalToConstant: 30),
            stopImageViewFilled.heightAnchor.constraint(equalTo: stopImageViewFilled.widthAnchor),
            stopImageViewFilled.centerXAnchor.constraint(equalTo: stopButton.centerXAnchor),
            stopImageViewFilled.centerYAnchor.constraint(equalTo: stopButton.centerYAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
    }

    @objc func playButtonTapped() {
        playButtonSetup()
    }

    @objc func pauseButtonTapped() {
        pauseButtonSetup()
    }

    @objc func stopButtonTapped() {
        stopButtonSetup()
    }

    func playButtonSetup() {
        playImageViewEmpty.isHidden = true
        playImageViewFilled.isHidden = false
        pauseImageViewEmpty.isHidden = false
        pauseImageViewFilled.isHidden = true
        stopImageViewEmpty.isHidden = false
        stopImageViewFilled.isHidden = true
    }

    func pauseButtonSetup() {
        playImageViewEmpty.isHidden = false
        playImageViewFilled.isHidden = true
        pauseImageViewEmpty.isHidden = true
        pauseImageViewFilled.isHidden = false
        stopImageViewEmpty.isHidden = false
        stopImageViewFilled.isHidden = true
    }

    func stopButtonSetup() {
        stopImageViewEmpty.isHidden = true
        stopImageViewFilled.isHidden = false
        playImageViewEmpty.isHidden = false
        playImageViewFilled.isHidden = true
        pauseImageViewEmpty.isHidden = false
        pauseImageViewFilled.isHidden = true
    }
}
