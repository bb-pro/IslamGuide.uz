//
//  QuranTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import UIKit

final class QuranTableViewController: UITableViewController {
    private let networkManager = NetworkManager.shared
    var data: [SurahData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSurah()
    }

}

//MARK: - Private Methods

private extension QuranTableViewController {
    func fetchSurah() {
        let url = URL(string: "https://api.alquran.cloud/v1/surah")!
        networkManager.fetch(QuranSurah.self, from: url) { result in
            switch result {
                case .success(let response):
                    self.data = response.data
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func fetchAyah() {
        let url = URL(string: "https://api.alquran.cloud/v1/ayah/2:255/en.asad")!
        networkManager.fetch(QuranAyah.self, from: url) { result in
            switch result {
                case .success(let response):
                    print(response.data.text)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}

// MARK: - Table view data source
extension QuranTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Surahs"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            if section == 0 {
                headerView.backgroundView?.backgroundColor = UIColor(named: "background")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuranCell
            let surah = data[indexPath.row]
            cell.titleEn.text = surah.englishName
            cell.titleArabic.text = surah.name
            cell.number.text = String(surah.number)
            cell.numberOfVerses.text = String("Number of ayahs: \(surah.numberOfAyahs)")
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension QuranTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        fetchAyah()
    }
}
