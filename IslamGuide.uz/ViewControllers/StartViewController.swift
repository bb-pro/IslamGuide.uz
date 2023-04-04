//
//  ViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import UIKit
import SpringAnimation

final class StartViewController: UIViewController {
    @IBOutlet var imageView: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    private func animate() {
        imageView.animation = "squeezeDown"
        imageView.duration = 2
        imageView.animate()
    }
}

