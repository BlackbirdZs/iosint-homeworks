//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Anton Kruglov on 06.08.2026.
//

import Foundation
import SnapKit
import UIKit

class ProfileHeaderView: UIView {
    private var statusText: String = ""

    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.image = UIImage(named: "avatar")
        return avatarImageView
    }()

    lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Hipster Shadowheart"
        fullNameLabel.textColor = .black
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return fullNameLabel
    }()

    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        return statusLabel
    }()

    lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowOffset = .init(width: 4, height: 4)
        setStatusButton.layer.shadowOpacity = 0.7

        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return setStatusButton
    }()

    lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.backgroundColor = .white
        statusTextField.placeholder = "Tell us how you're feeling today"
        statusTextField.textColor = .black
        statusTextField.font = UIFont.systemFont(ofSize: 15)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        statusTextField.leftView = paddingView
        statusTextField.leftViewMode = .always

        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)

        return statusTextField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)

        setupSnpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSnpConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }

        fullNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(11)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
        }

        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing)
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.height.equalTo(40)
        }

        setStatusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }

    @objc func buttonPressed() {
        statusLabel.text = statusText
        print(statusText)
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}
