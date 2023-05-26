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
        if let preferredLanguages = UserDefaults.standard.array(forKey: "AppleLanguages") as? [String],
           let preferredLanguage = preferredLanguages.first {
            print("Preferred Language: \(preferredLanguage)")
        } else {
            print("Preferred Language not found.")
        }
        animate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(
            timeInterval: 0,
            target: self,
            selector: #selector(showMain),
            userInfo: nil,
            repeats: false
        )
    }
    private func animate() {
        imageView.animation = "squeezeDown"
        imageView.duration = 1.5
        imageView.animate()
    }
    
    @objc func showMain() {
        performSegue(withIdentifier: "showMain", sender: nil)
    }
}

