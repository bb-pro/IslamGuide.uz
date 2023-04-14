//
//  PrayingTimeViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 13/04/23.
//

import UIKit

final class PrayingTimeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchData()
    }
    
}

//MARK: - Networking
private extension PrayingTimeViewController {
    func fetchData() {
        let url = URL(string: "https://dailyprayer.abdulrcs.repl.co/api/namangan")!
        networkManager.fetch(Praying.self, from: url) { result in
            switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension PrayingTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Praying Time"
        cell.contentConfiguration = content
        return cell
    }
}
