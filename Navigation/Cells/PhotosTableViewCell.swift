//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 03.09.2026.
//

import Foundation
import UIKit

class PhotosTableViewCell: UITableViewCell {
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

    private lazy var photosLabelView: UILabel = {
        let photosLabelView = UILabel()
        photosLabelView.translatesAutoresizingMaskIntoConstraints = false
        photosLabelView.backgroundColor = .white
        photosLabelView.text = "Photos"
        photosLabelView.textColor = .black
        photosLabelView.font = UIFont.systemFont(ofSize: 24, weight: .bold)

        return photosLabelView
    }()

    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(systemName: "arrow.right")
        arrowImage.backgroundColor = .clear

        return arrowImage
    }()

    private lazy var cellImage1: UIImageView = {
        let cellImage1 = UIImageView()
        cellImage1.translatesAutoresizingMaskIntoConstraints = false
        cellImage1.layer.cornerRadius = 6
        cellImage1.clipsToBounds = true
        cellImage1.layer.masksToBounds = true
        cellImage1.image = UIImage(named: "pic1")

        return cellImage1
    }()

    private lazy var cellImage2: UIImageView = {
        let cellImage2 = UIImageView()
        cellImage2.translatesAutoresizingMaskIntoConstraints = false
        cellImage2.layer.cornerRadius = 6
        cellImage2.clipsToBounds = true
        cellImage2.layer.masksToBounds = true
        cellImage2.image = UIImage(named: "pic2")

        return cellImage2
    }()

    private lazy var cellImage3: UIImageView = {
        let cellImage3 = UIImageView()
        cellImage3.translatesAutoresizingMaskIntoConstraints = false
        cellImage3.layer.cornerRadius = 6
        cellImage3.clipsToBounds = true
        cellImage3.layer.masksToBounds = true
        cellImage3.image = UIImage(named: "pic3")

        return cellImage3
    }()

    private lazy var cellImage4: UIImageView = {
        let cellImage4 = UIImageView()
        cellImage4.translatesAutoresizingMaskIntoConstraints = false
        cellImage4.layer.cornerRadius = 6
        cellImage4.clipsToBounds = true
        cellImage4.layer.masksToBounds = true
        cellImage4.image = UIImage(named: "pic4")

        return cellImage4
    }()

    func setupConstraints() {
        NSLayoutConstraint.activate([
            photosLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: photosLabelView.centerYAnchor),

            cellImage1.widthAnchor.constraint(equalTo: cellImage1.heightAnchor),
            cellImage1.topAnchor.constraint(equalTo: photosLabelView.bottomAnchor, constant: 12),
            cellImage1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            cellImage1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            cellImage2.widthAnchor.constraint(equalTo: cellImage1.widthAnchor),
            cellImage2.topAnchor.constraint(equalTo: cellImage1.topAnchor),
            cellImage2.bottomAnchor.constraint(equalTo: cellImage1.bottomAnchor),
            cellImage2.leadingAnchor.constraint(equalTo: cellImage1.trailingAnchor, constant: 8),

            cellImage3.widthAnchor.constraint(equalTo: cellImage1.widthAnchor),
            cellImage3.topAnchor.constraint(equalTo: cellImage1.topAnchor),
            cellImage3.bottomAnchor.constraint(equalTo: cellImage1.bottomAnchor),
            cellImage3.leadingAnchor.constraint(equalTo: cellImage2.trailingAnchor, constant: 8),

            cellImage4.widthAnchor.constraint(equalTo: cellImage1.widthAnchor),
            cellImage4.topAnchor.constraint(equalTo: cellImage1.topAnchor),
            cellImage4.bottomAnchor.constraint(equalTo: cellImage1.bottomAnchor),
            cellImage4.leadingAnchor.constraint(equalTo: cellImage3.trailingAnchor, constant: 8),
            cellImage4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }

    func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        accessoryType = .none
    }

    func addSubviews() {
        contentView.addSubview(photosLabelView)
        contentView.addSubview(arrowImage)
        contentView.addSubview(cellImage1)
        contentView.addSubview(cellImage2)
        contentView.addSubview(cellImage3)
        contentView.addSubview(cellImage4)
    }
}
