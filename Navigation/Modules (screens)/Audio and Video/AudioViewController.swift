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

    var player = AVAudioPlayer()

    let tracks = ["track1", "track2", "track3", "track4", "track5"]
    var currentTrackIndex: Int = 0

    func loadTrack(at index: Int) {
        player.stop()
        let trackName = tracks[index]
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: trackName, ofType: "mp3")!))
            player.prepareToPlay()
        } catch {
            print("error")
        }
    }

    func setupPlayer() {
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "track1", ofType: "mp3")!))
            player.prepareToPlay()
        } catch {
            print("error")
        }
    }

    private lazy var trackLabel: UILabel = {
        let trackLabel = UILabel()
        let songName = tracks[currentTrackIndex]
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        trackLabel.clipsToBounds = true
        trackLabel.layer.cornerRadius = 30
        trackLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        trackLabel.textAlignment = .center
        trackLabel.backgroundColor = .vk
        trackLabel.textColor = .white

        return trackLabel
    }()

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

    private lazy var nextTrackButton: UIButton = {
        let nextTrackButton = UIButton()
        nextTrackButton.translatesAutoresizingMaskIntoConstraints = false
        nextTrackButton.clipsToBounds = true
        nextTrackButton.layer.cornerRadius = 20

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return nextTrackButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        nextTrackButton.setBackgroundImage(bluePixel, for: .normal)
        nextTrackButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        nextTrackButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        nextTrackButton.setBackgroundImage(dimmedBluePixel, for: .disabled)
        nextTrackButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        return nextTrackButton
    }()

    private lazy var nextTrackViewEmpty: UIImageView = {
        let nextTrackViewEmpty = UIImageView()
        nextTrackViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        nextTrackViewEmpty.image = UIImage(systemName: "forward")
        nextTrackViewEmpty.isHidden = false
        nextTrackViewEmpty.backgroundColor = .clear
        nextTrackViewEmpty.tintColor = .white

        return nextTrackViewEmpty
    }()

    private lazy var nextTrackViewFilled: UIImageView = {
        let nextTrackViewEmpty = UIImageView()
        nextTrackViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        nextTrackViewEmpty.image = UIImage(systemName: "forward.fill")
        nextTrackViewEmpty.isHidden = true
        nextTrackViewEmpty.backgroundColor = .clear
        nextTrackViewEmpty.tintColor = .white

        return nextTrackViewEmpty
    }()

    private lazy var previousTrackButton: UIButton = {
        let previousTrackButton = UIButton()
        previousTrackButton.translatesAutoresizingMaskIntoConstraints = false
        previousTrackButton.clipsToBounds = true
        previousTrackButton.layer.cornerRadius = 20

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return previousTrackButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        previousTrackButton.setBackgroundImage(bluePixel, for: .normal)
        previousTrackButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        previousTrackButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        previousTrackButton.setBackgroundImage(dimmedBluePixel, for: .disabled)
        previousTrackButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)

        return previousTrackButton
    }()

    private lazy var previousTrackViewEmpty: UIImageView = {
        let nextTrackViewEmpty = UIImageView()
        nextTrackViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        nextTrackViewEmpty.image = UIImage(systemName: "backward")
        nextTrackViewEmpty.isHidden = false
        nextTrackViewEmpty.backgroundColor = .clear
        nextTrackViewEmpty.tintColor = .white

        return nextTrackViewEmpty
    }()

    private lazy var previousTrackViewFilled: UIImageView = {
        let previousTrackViewFilled = UIImageView()
        previousTrackViewFilled.translatesAutoresizingMaskIntoConstraints = false
        previousTrackViewFilled.image = UIImage(systemName: "backward.fill")
        previousTrackViewFilled.isHidden = true
        previousTrackViewFilled.backgroundColor = .clear
        previousTrackViewFilled.tintColor = .white

        return previousTrackViewFilled
    }()

    func setupView() {
        title = "Audio"
        view.backgroundColor = .systemGray
    }

    func addSubviews() {
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(stopButton)
        view.addSubview(nextTrackButton)
        view.addSubview(previousTrackButton)
        view.addSubview(trackLabel)
        playButton.addSubview(playImageViewEmpty)
        playButton.addSubview(playImageViewFilled)
        pauseButton.addSubview(pauseImageViewEmpty)
        pauseButton.addSubview(pauseImageViewFilled)
        stopButton.addSubview(stopImageViewEmpty)
        stopButton.addSubview(stopImageViewFilled)
        nextTrackButton.addSubview(nextTrackViewEmpty)
        nextTrackButton.addSubview(nextTrackViewFilled)
        previousTrackButton.addSubview(previousTrackViewEmpty)
        previousTrackButton.addSubview(previousTrackViewFilled)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            trackLabel.widthAnchor.constraint(equalToConstant: 300),
            trackLabel.heightAnchor.constraint(equalToConstant: 70),

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

            previousTrackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            previousTrackButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            previousTrackButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            previousTrackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),

            previousTrackViewEmpty.widthAnchor.constraint(equalToConstant: 30),
            previousTrackViewEmpty.heightAnchor.constraint(equalTo: previousTrackViewEmpty.widthAnchor),
            previousTrackViewEmpty.centerXAnchor.constraint(equalTo: previousTrackButton.centerXAnchor),
            previousTrackViewEmpty.centerYAnchor.constraint(equalTo: previousTrackButton.centerYAnchor),

            previousTrackViewFilled.widthAnchor.constraint(equalToConstant: 30),
            previousTrackViewFilled.heightAnchor.constraint(equalTo: previousTrackViewFilled.widthAnchor),
            previousTrackViewFilled.centerXAnchor.constraint(equalTo: previousTrackButton.centerXAnchor),
            previousTrackViewFilled.centerYAnchor.constraint(equalTo: previousTrackButton.centerYAnchor),

            nextTrackButton.leadingAnchor.constraint(equalTo: previousTrackButton.trailingAnchor, constant: 30),
            nextTrackButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            nextTrackButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            nextTrackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),

            nextTrackViewEmpty.widthAnchor.constraint(equalToConstant: 30),
            nextTrackViewEmpty.heightAnchor.constraint(equalTo: nextTrackViewEmpty.widthAnchor),
            nextTrackViewEmpty.centerXAnchor.constraint(equalTo: nextTrackButton.centerXAnchor),
            nextTrackViewEmpty.centerYAnchor.constraint(equalTo: nextTrackButton.centerYAnchor),

            nextTrackViewFilled.widthAnchor.constraint(equalToConstant: 30),
            nextTrackViewFilled.heightAnchor.constraint(equalTo: nextTrackViewEmpty.widthAnchor),
            nextTrackViewFilled.centerXAnchor.constraint(equalTo: nextTrackButton.centerXAnchor),
            nextTrackViewFilled.centerYAnchor.constraint(equalTo: nextTrackButton.centerYAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
        loadTrack(at: 0)
    }

    @objc func playButtonTapped() {
        playButtonSetup()
        player.play()
        updateTrackLabel()
    }

    @objc func pauseButtonTapped() {
        pauseButtonSetup()
        player.pause()
        updateTrackLabel()
    }

    @objc func stopButtonTapped() {
        stopButtonSetup()
        player.currentTime = 0
        player.stop()
        updateTrackLabel()
    }

    @objc func nextButtonTapped() {
        nextTrackViewEmpty.isHidden = true
        nextTrackViewFilled.isHidden = false
        currentTrackIndex += 1
        if currentTrackIndex >= tracks.count {
            currentTrackIndex = 0
        }
        loadTrack(at: currentTrackIndex)
        player.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.nextTrackViewFilled.isHidden = true
            self.nextTrackViewEmpty.isHidden = false
        }
        updateTrackLabel()
    }

    @objc func previousButtonTapped() {
        previousTrackViewEmpty.isHidden = true
        previousTrackViewFilled.isHidden = false
        currentTrackIndex -= 1
        if currentTrackIndex < 0 {
            currentTrackIndex = tracks.count - 1
        }
        loadTrack(at: currentTrackIndex)
        player.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.previousTrackViewFilled.isHidden = true
            self.previousTrackViewEmpty.isHidden = false
        }
        updateTrackLabel()
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

    func updateTrackLabel() {
        let currentTrackName = tracks[currentTrackIndex]
        if player.isPlaying {
            trackLabel.text = "Now playing: \(currentTrackName)"
        } else {
            trackLabel.text = "Paused: \(currentTrackName)"
        }
    }
}
