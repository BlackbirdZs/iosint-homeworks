//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 31.07.2026.
//

import StorageService
import UIKit

class FeedViewController: UIViewController {
    var feedModel = FeedModel()

    private lazy var firstButton: CustomButton = {
        let firstButton = CustomButton(title: "View the post", titleColor: .white)
        firstButton.translatesAutoresizingMaskIntoConstraints = false

        return firstButton
    }()

    private lazy var secondButton: CustomButton = {
        let secondButton = CustomButton(title: "View the post", titleColor: .white)
        secondButton.translatesAutoresizingMaskIntoConstraints = false

        return secondButton
    }()

    private lazy var checkLabel: UILabel = {
        let checkLabel = UILabel()
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        checkLabel.clipsToBounds = true
        checkLabel.backgroundColor = .yellow
        checkLabel.layer.cornerRadius = 25
        checkLabel.layer.borderWidth = 3
        checkLabel.layer.borderColor = UIColor.white.cgColor

        return checkLabel
    }()

    private lazy var feedTextField: UITextField = {
        let feedTextField = UITextField()
        feedTextField.translatesAutoresizingMaskIntoConstraints = false
        feedTextField.backgroundColor = .white
        feedTextField.textColor = .black
        feedTextField.layer.cornerRadius = 5
        feedTextField.placeholder = "Here you can type the secret word"
        feedTextField.autocapitalizationType = .none
        feedTextField.font = UIFont.systemFont(ofSize: 15)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        feedTextField.leftView = paddingView
        feedTextField.leftViewMode = .always

        return feedTextField
    }()

    private lazy var checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton(title: "Guess the secret word", titleColor: .white)
        checkGuessButton.translatesAutoresizingMaskIntoConstraints = false
        checkGuessButton.clipsToBounds = true
        checkGuessButton.backgroundColor = .systemCyan
        checkGuessButton.layer.cornerRadius = 5
        checkGuessButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        checkGuessButton.tapOnButton = { [weak self] in self?.guessButtonTapped() }

        return checkGuessButton
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
        addSubviews()
        setupConstraints()
        setupButtonActions()
    }

    func setupView() {
        view.backgroundColor = .blue
    }

    func addSubviews() {
        view.addSubview(buttonsStackView)
        view.addSubview(checkGuessButton)
        view.addSubview(feedTextField)
        view.addSubview(checkLabel)
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

    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            checkLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            checkLabel.widthAnchor.constraint(equalToConstant: 80),
            checkLabel.heightAnchor.constraint(equalTo: checkLabel.widthAnchor),

            feedTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            feedTextField.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 100),
            feedTextField.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -16),
            feedTextField.widthAnchor.constraint(equalTo: checkGuessButton.widthAnchor),
            feedTextField.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor),

            checkGuessButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 300),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),

            buttonsStackView.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
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

    @objc func guessButtonTapped() {
        guard let feedText = feedTextField.text else { return }
        let cleanedFeedText = feedText.trimmingCharacters(in: .whitespaces)
        if cleanedFeedText.isEmpty {
            showAlert(message: "Please, tell us the secret word.")
            checkLabel.backgroundColor = .yellow
            return
        }
        let isValid = feedModel.check(word: cleanedFeedText)
        if isValid {
            checkLabel.backgroundColor = .green
            showAlert(message: "You know the secret word, well done!")
        } else {
            checkLabel.backgroundColor = .red
            showAlert(message: "Incorrect secret word. You can try again.")
        }
    }
}
