//
//  MoviewSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit

final class MoviewSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.searchController = UISearchController()
    }


}

