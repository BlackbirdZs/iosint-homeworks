//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 31.07.2026.
//

import UIKit

class FeedViewController: UIViewController {
    private lazy var firstButton: UIButton = {
        let firstButton = UIButton()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.setTitle("View the post", for: .normal)

        return firstButton
    }()

    private lazy var secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.setTitle("View the post", for: .normal)

        return secondButton
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton, secondButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupButtonActions()
    }

    func setupView() {
        view.backgroundColor = .blue
        view.addSubview(buttonsStackView)
    }

    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    func setupButtonActions() {
        firstButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    let post = Post(title: "My post")

    @objc func buttonPressed() {
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
