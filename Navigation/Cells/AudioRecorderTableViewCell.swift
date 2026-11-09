//
//  AudioRecorderTableViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 09.11.2026.
//

import Foundation
import UIKit

class AudioRecorderTableViewCell: UITableViewCell {
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier
        )

        tuneView()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        isHidden = false
        isSelected = false
        isHighlighted = false
    }

    func tuneView() {
        contentView.backgroundColor = .systemGray
        contentView.backgroundColor = .white
        accessoryType = .none
    }

    private lazy var audioRecordLabelView: UILabel = {
        let audioLabelView = UILabel()
        audioLabelView.translatesAutoresizingMaskIntoConstraints = false
        audioLabelView.backgroundColor = .clear
        audioLabelView.text = "Record audio"
        audioLabelView.textColor = .black
        audioLabelView.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return audioLabelView
    }()

    private lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.image = UIImage(systemName: "arrow.right")
        arrowImageView.backgroundColor = .clear

        return arrowImageView
    }()

    func addSubviews() {
        contentView.addSubview(audioRecordLabelView)
        contentView.addSubview(arrowImageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            audioRecordLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            audioRecordLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: audioRecordLabelView.centerYAnchor),

        ])
    }
}
