//
//  BooksSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit

extension BooksSearchViewController {
    func setAllConstraints() {
        setConstraintsOfTableView()
    }
    
    func setConstraintsOfTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
