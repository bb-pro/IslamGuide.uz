//
//  AyahTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 05/04/23.
//

import UIKit

final class AyahTableViewController: UITableViewController {
    var ayahs: [Ayah] = []
    var arabicAyahs: [Ayah] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 800
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
            return ayahs.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Ayahs"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ayahCell", for: indexPath) as! AyahCell
            let ayah = ayahs[indexPath.row]
            cell.arabicLabel.text = arabicAyahs[indexPath.row].text
            cell.englishLabel.text = ayah.text
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension AyahTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
