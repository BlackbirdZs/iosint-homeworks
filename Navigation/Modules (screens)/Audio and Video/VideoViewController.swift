//
//  VideoViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 05.11.2026.
//

import AVKit
import Foundation
import UIKit

class VideoViewController: UIViewController {
    private let videoPosts = VideoPost.make()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .plain
        )

        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        tuneTableView()
        setupConstraints()
    }

    func setupView() {
        title = "Videos"
        view.backgroundColor = .white
    }

    func addSubviews() {
        view.addSubview(tableView)
    }

    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .clear
        tableView.register(VideoPostTableViewCell.self, forCellReuseIdentifier: "video cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
        ])
    }
}

extension VideoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "video cell",
            for: indexPath
        ) as? VideoPostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        let videos = videoPosts[indexPath.row]
        cell.configure(with: videos)
        return cell
    }
}

extension VideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videoPosts[indexPath.row]
        guard let url = URL(string: video.url) else { return }
        let playerViewController = AVPlayerViewController()
        let player = AVPlayer(url: url)
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}
