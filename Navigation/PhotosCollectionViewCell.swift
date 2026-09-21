//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 04.09.2026.
//

import Foundation
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    // image
    private lazy var collectionImageView: UIImageView = {
        let collectionImageView = UIImageView(frame: .zero)
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        collectionImageView.contentMode = .scaleAspectFill

        return collectionImageView
    }()

    // lifecycl
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupView()
        addSubview()
        setupLayouts()
    }

    func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }

    private func addSubview() {
        contentView.addSubview(collectionImageView)
    }

    func setupLayouts() {
        NSLayoutConstraint.activate([
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func configure(imageName: String) {
        collectionImageView.image = UIImage(named: imageName)
    }
}
