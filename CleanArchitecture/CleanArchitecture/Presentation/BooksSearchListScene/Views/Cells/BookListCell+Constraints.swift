//
//  BookListCell+Constraints.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit

extension BookListCell {
    func setAllConstraints() {
        setConstraintsOfPosterImageView()
        setConstraintsOfStackView()
    }
    
    private func setConstraintsOfPosterImageView() {
        let bottom = posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottom.priority = .defaultLow
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setConstraintsOfStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
