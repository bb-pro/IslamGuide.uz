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
        let swiftUIRootView = CompassView()
        compassView = UIHostingController(rootView: swiftUIRootView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let compassView = compassView {
            addChild(compassView)
            view.addSubview(compassView.view)
            compassView.didMove(toParent: self)
            
            // Set the frame of the SwiftUI view to match the hosting view controller's view
            compassView.view.frame = view.bounds
            compassView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
}
