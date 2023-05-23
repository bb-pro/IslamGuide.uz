//
//  SettingCell.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/05/23.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet var styleSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if !sender.isOn {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        }
        
    }
    
    func styleView() {
        var osTheme: UIUserInterfaceStyle {
            return UIScreen.main.traitCollection.userInterfaceStyle
        }
        if osTheme == .dark {
            styleSwitch.setOn(true, animated: true)
        } else {
            styleSwitch.setOn(false, animated: true)
        }
    }
    
}
