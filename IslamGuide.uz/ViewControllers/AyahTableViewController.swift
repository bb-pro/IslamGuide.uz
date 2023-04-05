//
//  AyahTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 05/04/23.
//

import UIKit

final class AyahTableViewController: UITableViewController {
    var surah: SurahData!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
// MARK: - Table view data source
extension AyahTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return surah.numberOfAyahs
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        } else {
             return 70
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ayahCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "Ayah"
            cell.contentConfiguration = content
            return cell
        }
    }
}
