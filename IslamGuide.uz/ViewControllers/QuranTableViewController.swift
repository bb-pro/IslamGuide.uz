//
//  QuranTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import UIKit

final class QuranTableViewController: UIViewController {
    var response: QuranResponse?
    private var arabicResponse: QuranResponse?
    private var quranVersion: String!
    private let networkManager = NetworkManager.shared
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchArabic()
        fetchTranslation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let preferredLanguage = Locale.preferredLanguages.first else { return }
        
        print(preferredLanguage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ayahVC = segue.destination as? AyahTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow?.row else { return }
        ayahVC.ayahs = response?.data.surahs[indexPath].ayahs ?? []
        ayahVC.arabicAyahs = arabicResponse?.data.surahs[indexPath].ayahs ?? []
        ayahVC.navigationItem.title = response?.data.surahs[indexPath].englishName
        ayahVC.hidesBottomBarWhenPushed = true
    }
}

//MARK: - Private Methods
private extension QuranTableViewController {
    func fetchTranslation() {
        networkManager.getData(for: "en.asad") { [weak self] result in
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
        networkManager.getData(for: "ar.alafasy") { [weak self] result in
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
extension QuranTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return response?.data.surahs.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            if section == 0 {
                headerView.backgroundView?.backgroundColor = UIColor(named: "background")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

//MARK: - UITableViewDelegate
extension QuranTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

