//
//  LoadingView.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/03.
//

import UIKit

final class LoadingView {

    static var spinner: UIActivityIndicatorView?
    private static let maximumTime: UInt32 = 3

    static func show() {
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
            if spinner == nil, let window = UIApplication.shared.windows.first {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                spinner.style = .large
                window.addSubview(spinner)

                spinner.startAnimating()
                self.spinner = spinner
            }
        }
        DispatchQueue.global().async {
            sleep(maximumTime)
            LoadingView.hide()
        }
    }

    public static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }

    @objc public static func update() {
        DispatchQueue.main.async {
            if spinner != nil {
                hide()
                show()
            }
        }
    }
}
