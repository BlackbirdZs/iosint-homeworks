//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 03.09.2026.
//

import Foundation
import iOSIntPackage
import UIKit

class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    var images: [UIImage] = []

    private let photosCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground

        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")

        return collectionView
    }()

    private let facade = ImagePublisherFacade()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupCollectionView()
        setupLayouts()
        subToFacade()
        setupTimer()
    }

    func subToFacade() {
        facade.subscribe(self)
    }

    func setupTimer() {
        let collectionImages = (1 ... 20).compactMap { UIImage(named: "pic\($0)") }
        facade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: collectionImages)
    }

    func removeSub() {
        facade.removeSubscription(for: self)
    }

    func setupView() {
        view.backgroundColor = .systemGray6
        photosCollectionView.backgroundColor = .white
    }

    func setupCollectionView() {
        view.addSubview(photosCollectionView)

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }

    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.backgroundColor = .clear
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        removeSub()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.configure(image: images[indexPath.item])
        return cell
    }
}

enum Constants {
    static let spacing: CGFloat = 8.0
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8.0
        let itemsPerRow: CGFloat = 3
        let totalSpacing = spacing * 2 + spacing * 2
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow

        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spacing
    }
}

extension PhotosViewController {
    func receive(images: [UIImage]) {
        self.images = images
        photosCollectionView.reloadData()
    }
}
