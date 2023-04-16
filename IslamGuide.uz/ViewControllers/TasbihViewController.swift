//
//  TasbihViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 11/04/23.
//

import UIKit

final class TasbihViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var countLabel: UILabel!
    
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func countButtonPressed() {
        if count < 33 {
            count += 1
        }
        countLabel.text = count.formatted()
        let currentDate = Date()
       
        let calendar = Calendar.current
        print(calendar.component(.day, from: currentDate))
    }
    
    
    @IBAction func refreshButtonPressed() {
        count = 0
        countLabel.text = count.formatted()
    }
}
