//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 05.11.2026.
//

import Foundation
import UIKit

class VideoTableViewCell: UITableViewCell {
    override init(
        style: UITableViewCell.CellStyle, reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier
        )
        setupView()
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

    private lazy var videoLabelView: UILabel = {
        let videoLabelView = UILabel()
        videoLabelView.translatesAutoresizingMaskIntoConstraints = false
        videoLabelView.backgroundColor = .clear
        videoLabelView.text = "Video"
        videoLabelView.textColor = .black
        videoLabelView.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return videoLabelView
    }()

    private lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.image = UIImage(systemName: "arrow.right")
        arrowImageView.backgroundColor = .clear

        return arrowImageView
    }()

    func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        accessoryType = .none
    }

    func addSubviews() {
        contentView.addSubview(videoLabelView)
        contentView.addSubview(arrowImageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            videoLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            videoLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: videoLabelView.centerYAnchor),
        ])
    }
}
