//
//  LoadingViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 06/04/23.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
    }
    override func viewWillDisappear(_ animated: Bool) {
        activityIndicator.stopAnimating()
    }
}
