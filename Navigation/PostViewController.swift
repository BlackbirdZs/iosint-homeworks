//
//  PostViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 31.07.2026.
//

import StorageService
import UIKit

class PostViewController: UIViewController {
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupView()
        setupNavBar()
    }

    func setupTitle() {
        title = post?.title
    }

    func setupView() {
        view.backgroundColor = .brown
    }

    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(infoButtonPressed))
    }

    @objc private func infoButtonPressed() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
