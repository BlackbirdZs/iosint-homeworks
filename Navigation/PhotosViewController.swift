//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Anton Kruglov on 03.09.2026.
//

import Foundation
import iOSIntPackage
import UIKit

class PhotosViewController: UIViewController {
    let photos = ["pic1", "pic2", "pic3", "pic4", "pic5", "pic6", "pic7", "pic8", "pic9", "pic10", "pic11", "pic12", "pic13", "pic14", "pic15", "pic16", "pic17", "pic18", "pic19", "pic20"]

    var processedImages: [UIImage] = []

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupCollectionView()
        setupLayouts()
    }

    func processImages() {
        let sourseImages: [UIImage] = photos.compactMap { UIImage(named: $0) }
        let processor = ImageProcessor()
        let startTime = CFAbsoluteTimeGetCurrent()

        processor.processImagesOnThread(
            sourceImages: sourseImages,
            filter: .bloom(intensity: 0.5),
            qos: .userInitiated) { [weak self] resultCGImages in
                
                let endTime = CFAbsoluteTimeGetCurrent()
                let duration = endTime - startTime
                print("The process time took \(duration) seconds")
                
                
                
            }
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
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        if !processedImages.isEmpty && indexPath.item < processedImages.count {
            cell.configure(image: processedImages[indexPath.item])
        } else {
            let image = UIImage(named: photos[indexPath.item]) ?? UIImage()
            cell.configure(image: image)
        }
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
