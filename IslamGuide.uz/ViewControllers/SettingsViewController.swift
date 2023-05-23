//
//  SettingsViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/05/23.
//

import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
                cell.styleView()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell", for: indexPath) as! SettingCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! SettingCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! SettingCell
                return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
