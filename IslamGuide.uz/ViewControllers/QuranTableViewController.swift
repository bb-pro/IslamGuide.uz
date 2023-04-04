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
        fetchData()
    }

}

//MARK: - Private Methods

private extension QuranTableViewController {
    func fetchData() {
        networkManager.fetchQuranData { [weak self] result in
            switch result {
                case .success(let response):
                    
                    self?.data = response.data
                    self?.tableView.reloadData()
                    print(self?.data[0].name)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Table view data source
extension QuranTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuranCell
        let number = String(indexPath.row + 1)
        let surah = data[indexPath.row]
        cell.titleEn.text = surah.englishName
        cell.titleArabic.text = surah.name
        cell.number.text = number
        return cell
    }
}
