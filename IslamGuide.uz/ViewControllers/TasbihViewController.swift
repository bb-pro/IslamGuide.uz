//
//  TasbihViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 11/04/23.
//

import UIKit
import SpringAnimation

final class TasbihViewController: UIViewController {
    
    @IBOutlet var numberButton: SpringButton!
    @IBOutlet var refreshButton: SpringButton!
    
    @IBOutlet var countLabel: SpringLabel!
    @IBOutlet var numberLabel: UILabel!
    
    private var count = 0
    private var largestCount = 33
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func countButtonPressed() {
        if count < largestCount {
            count += 1
        }
        animateCountLabel()
        countLabel.text = count.formatted()
    }
    
    
    @IBAction func refreshButtonPressed() {
        count = 0
        countLabel.text = count.formatted()
        animateButton(sender: refreshButton)
    }
    
    @IBAction func numberButtonPressed() {
        animateButton(sender: numberButton)
        if largestCount == 33 {
            largestCount = 99
        } else {
            largestCount = 33
        }
        
        numberButton.setTitle(largestCount.formatted(), for: .normal)
        numberLabel.text = "/  \(largestCount)"
    }
    
    private func animateCountLabel() {
        countLabel.animation = "zoomIn"
        countLabel.duration = 1
        countLabel.animate()
    }
    private func animateButton(sender: SpringButton) {
        sender.animation = "zoomIn"
        sender.duration = 1.6
        sender.animate()
    }
}
