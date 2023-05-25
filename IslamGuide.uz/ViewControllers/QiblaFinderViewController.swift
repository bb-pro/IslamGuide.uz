//
//  QiblaFinderViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 17/05/23.
//

import SwiftUI

final class QiblaFinderViewController: UIViewController {
    private var compassView: UIHostingController<CompassView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Qibla Finder"
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    private func setupCompassView() {
        guard let compassView = compassView else {
            return
        }
        addChild(compassView)
        view.addSubview(compassView.view)
        compassView.didMove(toParent: self)

        // Set the frame of the SwiftUI view to match the hosting view controller's view
        compassView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compassView.view.topAnchor.constraint(equalTo: view.topAnchor),
            compassView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            compassView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            compassView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func updateUI() {
        if compassView == nil {
            let swiftUIRootView = CompassView()
            compassView = UIHostingController(rootView: swiftUIRootView)
            setupCompassView()
        }
    }
}

