//
//  UITableView+Extension.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/03.
//

import UIKit

extension UITableView {
    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style = .medium
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
}
