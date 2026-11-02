//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Anton Kruglov on 01.09.2026.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )
        tuneView()
        addSubviewsPost()
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
        aboveLabel.text = "Нетология. Меняем карьеру через образование"
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

    private lazy var descriptionField: UILabel = {
        let descriptionField = UILabel()
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        descriptionField.text = "От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для окорения топов AppStore — пора начинать действовать! Профессия «iOS-разработчик» — тот самый путь, по которому стоит пройти до самого конца. Вы научитесь создавать приложения на языке. Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу — VK-like приложение с возможностью публиковать фотографии, использовать ильтры, ставить лайки и подписываться на других пользователей."
        descriptionField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionField.textColor = .systemGray
        descriptionField.numberOfLines = 0
        return descriptionField
    }()

    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.backgroundColor = .systemBackground
        likesLabel.text = "Likes: 766"
        likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
        likesLabel.textColor = .black
        return likesLabel
    }()

    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.backgroundColor = .systemBackground
        viewsLabel.text = "Views: 893"
        viewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
        viewsLabel.textColor = .black
        return viewsLabel
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

            descriptionField.topAnchor.constraint(equalTo: imageField.bottomAnchor, constant: 16),
            descriptionField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            viewsLabel.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    private func tuneView() {
        contentView.backgroundColor = .white
        accessoryType = .none
    }

    func configure(with post: FeedPost) {
        aboveLabel.text = post.author
        imageField.image = UIImage(named: post.image)
        descriptionField.text = post.description
        likesLabel.text = "Likes \(post.likes)"
        viewsLabel.text = "Views \(post.views)"
    }

    private func addSubviewsPost() {
        contentView.addSubview(aboveLabel)
        contentView.addSubview(imageField)
        contentView.addSubview(descriptionField)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
}
