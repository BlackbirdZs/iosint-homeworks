//
//  VideoPostTableViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 09.11.2026.
//

import Foundation
import UIKit

class VideoPostTableViewCell: UITableViewCell {
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
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

    private lazy var aboveLabel: UILabel = {
        let aboveLabel = UILabel()
        aboveLabel.translatesAutoresizingMaskIntoConstraints = false
        aboveLabel.backgroundColor = .white
        aboveLabel.numberOfLines = 2
        aboveLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        aboveLabel.textColor = .black

        return aboveLabel
    }()

    private lazy var imageField: UIImageView = {
        let imageField = UIImageView()
        imageField.translatesAutoresizingMaskIntoConstraints = false
        imageField.backgroundColor = .black
        imageField.contentMode = .scaleAspectFit

        return imageField
    }()

    func setupConstraints() {
        NSLayoutConstraint.activate([
            aboveLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            aboveLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aboveLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            imageField.topAnchor.constraint(equalTo: aboveLabel.bottomAnchor, constant: 16),
            imageField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageField.heightAnchor.constraint(equalTo: imageField.widthAnchor),
            imageField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    private func tuneView() {
        contentView.backgroundColor = .white
        accessoryType = .none
    }

    func configure(with videoPost: VideoPost) {
        aboveLabel.text = videoPost.title
        imageField.image = UIImage(named: videoPost.image)
    }

    private func addSubviews() {
        contentView.addSubview(aboveLabel)
        contentView.addSubview(imageField)
    }
}
