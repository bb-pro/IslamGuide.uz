//
//  TasbihViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 11/04/23.
//

import UIKit
import SpringAnimation
import AudioToolbox

final class TasbihViewController: UIViewController {
    
    @IBOutlet var numberButton: SpringButton!
    @IBOutlet var refreshButton: SpringButton!
    
    @IBOutlet var countLabel: SpringLabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var pressButton: SpringButton!
    
    private var count = 0
    private var largestCount = 33
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func countButtonPressed() {
        if count < largestCount {
            count += 1
        } else {
            vibrateDevice()
        }
        animateCountLabel()
        countLabel.text = count.formatted()
    }
    
    
    @IBAction func refreshButtonPressed() {
        vibrateDevice()
        count = 0
        countLabel.text = count.formatted()
        animateButton(sender: refreshButton)
    }
    
    @IBAction func numberButtonPressed() {
        animateButton(sender: numberButton)
        if largestCount == 33 {
            vibrateDevice()
            largestCount = 99
        } else {
            vibrateDevice()
            largestCount = 33
        }
        
        numberButton.setTitle(largestCount.formatted(), for: .normal)
        numberLabel.text = "/  \(largestCount)"
    }
    
    private func animateCountLabel() {
        countLabel.animation = "slideUp"
        countLabel.duration = 0.5
        countLabel.animate()
    }
    private func animateButton(sender: SpringButton) {
        sender.animation = "zoomIn"
        sender.duration = 1.6
        sender.animate()
    }
    
    private func vibrateDevice() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
