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
    private var prayingTime: Praying?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
    }
    
}

//MARK: - Networking
private extension PrayingTimeViewController {
    func fetchData() {
        let url = URL(string: "https://dailyprayer.abdulrcs.repl.co/api/namangan")!
        networkManager.fetch(Praying.self, from: url) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.prayingTime = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension PrayingTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! PrayingTimeCell
        guard let prayingTime else { return cell }
        
        switch indexPath.row {
            case 0:
                cell.nameLabel.text = "Bomdod: "
                cell.timeLabel.text = prayingTime.today.fajr
            case 1:
                cell.nameLabel.text = "Quyosh chiqishi: "
                cell.timeLabel.text = prayingTime.today.sunrise
            case 2:
                cell.nameLabel.text = "Peshin: "
                cell.timeLabel.text = prayingTime.today.dhuhr
            case 3:
                cell.nameLabel.text = "Asr: "
                cell.timeLabel.text = prayingTime.today.asr
            case 4:
                cell.nameLabel.text = "Shom: "
                cell.timeLabel.text = prayingTime.today.maghrib
            default:
                cell.nameLabel.text = "Xufton: "
                cell.timeLabel.text = prayingTime.today.isha
        }
        return cell
    }
}
//MARK: - UITableViewDelegate
extension PrayingTimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
