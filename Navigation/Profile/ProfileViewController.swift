//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 31.07.2026.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileHeaderView = ProfileHeaderView()
    fileprivate let posts = FeedPost.make()
    private var avatarPreviousFrame: CGRect = .zero

    private lazy var avatarBackgroundView: UIView = {
        let avatarBackgroundView = UIView()
        avatarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        avatarBackgroundView.backgroundColor = .black
        avatarBackgroundView.alpha = 0.0

        return avatarBackgroundView
    }()

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.isUserInteractionEnabled = true
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.alpha = 0.0
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)

        return closeButton
    }()

    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.image = profileHeaderView.avatarImageView.image
        avatarImageView.alpha = 0.0
        avatarImageView.clipsToBounds = true
        avatarImageView.isHidden = true

        return avatarImageView
    }()

    private lazy var avatarTap: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
    }()

    @objc private func didTapAvatar() {
        let avatar = profileHeaderView.avatarImageView

        avatarPreviousFrame = avatar.convert(avatar.bounds, to: view)
        avatarImageView.layer.cornerRadius = avatarPreviousFrame.height / 2
    

        avatarImageView.isHidden = false
        avatarImageView.frame = avatarPreviousFrame
        avatarImageView.alpha = 1.0
        avatar.isHidden = true

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                           self.avatarImageView.center = CGPoint(
                               x: self.view.center.x,
                               y: self.view.center.y
                           )
                           let avatarWidth = self.view.bounds.width
                           self.avatarImageView.bounds = CGRect(x: 0, y: 0, width: avatarWidth, height: avatarWidth)
                           self.avatarBackgroundView.alpha = 0.8
                           self.avatarImageView.layer.cornerRadius = 0
                       }, completion: { _ in
                           UIView.animate(withDuration: 0.3) {
                               self.closeButton.alpha = 1.0
                           }
                       })
    }

    @objc private func didTapCloseButton() {
        let avatar = profileHeaderView.avatarImageView

        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.closeButton.alpha = 0.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               options: .curveEaseOut,
                               animations: {
                                   self.avatarBackgroundView.alpha = 0.0
                                   self.avatarImageView.frame = self.avatarPreviousFrame
                                   self.avatarImageView.layer.cornerRadius = avatar.layer.cornerRadius
                               }, completion: { _ in
                                   self.avatarImageView.isHidden = true
                                   avatar.isHidden = false
                               })
            })
    }

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
        setupConstraints()
        tuneTableView()
        setupAvatarForTap()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
    }

    func setupAvatarForTap() {
        profileHeaderView.avatarImageView.isUserInteractionEnabled = true
        profileHeaderView.avatarImageView.addGestureRecognizer(avatarTap)
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(avatarBackgroundView)
        view.addSubview(avatarImageView)
        view.addSubview(closeButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),

            avatarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            avatarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            closeButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
        ])
    }

    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Base cell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "Photos cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return posts.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "Base cell",
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            let post = posts[indexPath.row]
            cell.configure(with: post)
            return cell
        } else {
            guard let photosCell = tableView.dequeueReusableCell(withIdentifier: "Photos cell", for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            return photosCell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileHeaderView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}
