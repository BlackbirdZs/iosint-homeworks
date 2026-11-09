//
//  AudioRecordViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 09.11.2026.
//

import AVFoundation
import Foundation
import UIKit

class AudioRecordViewController: UIViewController {
    private func imageWithAlpha(_ image: UIImage, alpha: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        return renderer.image { _ in image.draw(at: .zero, blendMode: .normal, alpha: alpha)
        }
    }

    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var recordUrl: URL?

    private lazy var recordButton: UIButton = {
        let recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.clipsToBounds = true
        recordButton.layer.cornerRadius = 30

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return recordButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        recordButton.setBackgroundImage(bluePixel, for: .normal)
        recordButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        recordButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        recordButton.setBackgroundImage(dimmedBluePixel, for: .disabled)

        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)

        return recordButton
    }()

    private lazy var recordImageViewEmpty: UIImageView = {
        let recordImageViewEmpty = UIImageView()
        recordImageViewEmpty.translatesAutoresizingMaskIntoConstraints = false
        recordImageViewEmpty.image = UIImage(systemName: "record.circle")
        recordImageViewEmpty.isHidden = false
        recordImageViewEmpty.backgroundColor = .clear
        recordImageViewEmpty.tintColor = .systemRed

        return recordImageViewEmpty
    }()

    private lazy var recordImageViewFilled: UIImageView = {
        let recordImageViewFilled = UIImageView()
        recordImageViewFilled.translatesAutoresizingMaskIntoConstraints = false
        recordImageViewFilled.image = UIImage(systemName: "record.circle.fill")
        recordImageViewFilled.isHidden = true
        recordImageViewFilled.backgroundColor = .clear
        recordImageViewFilled.tintColor = .systemRed

        return recordImageViewFilled
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

    private func saveRecord() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".m4a"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        return fileURL
    }

    private func startRecording() {
        recordUrl = saveRecord()
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]
        audioRecorder = try? AVAudioRecorder(url: recordUrl!, settings: settings)
        audioRecorder?.record()
        recordButtonSetup()
    }

    func setupView() {
        title = "Audio recorder"
        view.backgroundColor = .systemGray
    }

    func addSubviews() {
        view.addSubview(recordButton)
        view.addSubview(playButton)
        view.addSubview(stopButton)
        recordButton.addSubview(recordImageViewEmpty)
        recordButton.addSubview(recordImageViewFilled)
        playButton.addSubview(playImageViewEmpty)
        playButton.addSubview(playImageViewFilled)
        stopButton.addSubview(stopImageViewEmpty)
        stopButton.addSubview(stopImageViewFilled)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recordButton.widthAnchor.constraint(equalToConstant: 80),
            recordButton.heightAnchor.constraint(equalTo: recordButton.widthAnchor),

            recordImageViewEmpty.widthAnchor.constraint(equalToConstant: 30),
            recordImageViewEmpty.heightAnchor.constraint(equalTo: recordImageViewEmpty.widthAnchor),
            recordImageViewEmpty.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            recordImageViewEmpty.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor),

            recordImageViewFilled.widthAnchor.constraint(equalToConstant: 30),
            recordImageViewFilled.heightAnchor.constraint(equalTo: recordImageViewFilled.widthAnchor),
            recordImageViewFilled.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            recordImageViewFilled.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor),

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

            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
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

    func recordButtonSetup() {
        recordImageViewEmpty.isHidden = true
        recordImageViewFilled.isHidden = false
        playImageViewEmpty.isHidden = false
        playImageViewFilled.isHidden = true
        stopImageViewEmpty.isHidden = false
        stopImageViewFilled.isHidden = true
    }

    func playButtonSetup() {
        recordImageViewEmpty.isHidden = false
        recordImageViewFilled.isHidden = true
        playImageViewEmpty.isHidden = true
        playImageViewFilled.isHidden = false
        stopImageViewEmpty.isHidden = false
        stopImageViewFilled.isHidden = true
    }

    func stopButtonSetup() {
        recordImageViewEmpty.isHidden = false
        recordImageViewFilled.isHidden = true
        stopImageViewEmpty.isHidden = true
        stopImageViewFilled.isHidden = false
        playImageViewEmpty.isHidden = false
        playImageViewFilled.isHidden = true
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Attention",
            message: message,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(
            title: "Done",
            style: .default
        )
        alert.addAction(doneAction)
        present(alert, animated: true)
    }

    @objc func recordButtonTapped() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    self?.startRecording()
                } else {
                    self?.showAlert(message: "Please, enable microphone access in settings")
                }
            }
        }
    }

    @objc func playButtonTapped() {
        guard let recordUrl else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recordUrl)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
        playButtonSetup()
    }

    @objc func stopButtonTapped() {
        audioRecorder?.stop()
        audioPlayer?.stop()
        stopButtonSetup()
    }
}
