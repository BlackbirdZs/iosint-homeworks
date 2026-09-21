//
//  InfoViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 04.08.2026.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hi! This is a new screen.", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
        buttonActionSetup()
    }

    func setupView() {
        view.backgroundColor = .cyan
        title = "Information"
    }

    func addSubviews() {
        view.addSubview(infoButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    func buttonActionSetup() {
        infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
    }

    @objc private func infoButtonPressed() {
        let alert = UIAlertController(
            title: "Buttons are tappable!",
            message: "Some of the buttons below will be tapped.",
            preferredStyle: .alert
        )

        let confirmAction = UIAlertAction(title: "Done",
                                          style: .default) { _ in
            print("User has tapped the Done button.")
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("User has tapped the Cancel button.")
        }

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}
