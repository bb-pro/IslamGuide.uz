//
//  QuranTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import UIKit

final class QuranTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    var response: QuranResponse?
    private var arabicResponse: QuranResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferredLanguage = Locale.preferredLanguages.first
        fetchArabic()
        fetchTranslation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ayahVC = segue.destination as? AyahTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow?.row else { return }
        ayahVC.ayahs = response?.data.surahs[indexPath].ayahs ?? []
        ayahVC.arabicAyahs = arabicResponse?.data.surahs[indexPath].ayahs ?? []
    }
    
}

//MARK: - Private Methods

private extension QuranTableViewController {
    func fetchTranslation() {
        networkManager.getData(for: "ru.kuliev") { [weak self] result in
            switch result {
                case .success(let data):
                    self?.response = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    func fetchArabic() {
        networkManager.getData(for: "quran") { [weak self] result in
            switch result {
                case .success(let data):
                    self?.arabicResponse = data
                case .failure(let error):
                    print(error)
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
            return response?.data.surahs.count ?? 1
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 176
        } else {
            return 72
        }
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
            guard let surah = response?.data.surahs[indexPath.row] else {
                      // Return an empty cell if response is nil
                      return UITableViewCell()
                  }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuranCell
            cell.titleEn.text = surah.englishName
            cell.titleArabic.text = surah.name
            cell.number.text = String(surah.number)
            cell.numberOfVerses.text = String("Number of ayahs: \(surah.ayahs.count)")
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension QuranTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

