//
//  BooksSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import UIKit

extension BooksSearchViewController {
    func setAllConstraints() {
        setConstraintsOfTableView()
        setConstraintsOfEmptyLabel()
    }
    
    func setConstraintsOfTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setConstraintsOfEmptyLabel() {
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
