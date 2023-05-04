//
//  SettingCell.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/05/23.
//

import UIKit

final class SettingCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        if !sender.isOn {
            window?.overrideUserInterfaceStyle = .light
        } else {
            window?.overrideUserInterfaceStyle = .dark
        }
    }
}
