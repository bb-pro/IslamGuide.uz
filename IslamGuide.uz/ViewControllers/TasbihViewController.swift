//
//  TasbihViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 11/04/23.
//

import UIKit

final class TasbihViewController: UIViewController {
    
    @IBOutlet var numberButton: UIButton!
    @IBOutlet var refreshButton: UIButton!
    
    @IBOutlet var countLabel: UILabel!
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
        countLabel.text = count.formatted()
    }
    
    
    @IBAction func refreshButtonPressed() {
        count = 0
        countLabel.text = count.formatted()
    }
    
    @IBAction func numberButtonPressed() {
        if largestCount == 33 {
            largestCount = 99
        } else {
            largestCount = 33
        }
        
        numberButton.setTitle(largestCount.formatted(), for: .normal)
        numberLabel.text = "/  \(largestCount)"
    }
}
