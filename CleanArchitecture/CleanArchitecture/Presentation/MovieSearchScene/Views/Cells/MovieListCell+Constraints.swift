//
//  MovieListCell+Constraints.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit

extension MovieListCell {
    func setAllConstraints() {
        setConstraintsOfPosterImageView()
        setConstraintsOfTitleLabel()
        setConstraintsOfDateLabel()
        setConstraintsOfDescriptionLabel()
    }
    
    private func setConstraintsOfPosterImageView() {
        let bottom = posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottom.priority = .defaultLow
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            posterImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            bottom
        ])
    }
    
    private func setConstraintsOfTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -10)
        ])
    }
    
    private func setConstraintsOfDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setConstraintsOfDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10)
        ])
    }
}
