//
//  AudioTableViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 05.11.2026.
//

import Foundation
import UIKit

class AudioTableViewCell: UITableViewCell {
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

    private lazy var audioLabelView: UILabel = {
        let audioLabelView = UILabel()
        audioLabelView.translatesAutoresizingMaskIntoConstraints = false
        audioLabelView.backgroundColor = .clear
        audioLabelView.text = "Audio"
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

    func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        accessoryType = .none
    }

    func addSubviews() {
        contentView.addSubview(audioLabelView)
        contentView.addSubview(arrowImageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            audioLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            audioLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: audioLabelView.centerYAnchor),

        ])
    }
}
