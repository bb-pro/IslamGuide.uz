//
//  PrayingTimeViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 13/04/23.
//

import UIKit
import Adhan

final class PrayingTimeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let networkManager = NetworkManager.shared
    private var prayingTime: PrayerTimes?
    
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
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: 40, longitude: 71)
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = .hanafi
        guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else { return }

     
//        print("fajr \(formatter.string(from: prayers.fajr))")
//        print("sunrise \(formatter.string(from: prayers.sunrise))")
//        print("dhuhr \(formatter.string(from: prayers.dhuhr))")
//        print("asr \(formatter.string(from: prayers.asr))")
//        print("maghrib \(formatter.string(from: prayers.maghrib))")
//        print("isha \(formatter.string(from: prayers.isha))")
        
        prayingTime = prayers
        
        
        
    }
}

//MARK: - UITableViewDataSource
extension PrayingTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! PrayingTimeCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Hours and minutes format
        
        guard let prayingTime else { return cell }
        
        switch indexPath.row {
            case 0:
                cell.nameLabel.text = "Fajr"
                cell.timeLabel.text = formatter.string(from: prayingTime.fajr)
            case 1:
                cell.nameLabel.text = "Sunrise"
                cell.timeLabel.text = formatter.string(from: prayingTime.sunrise)
            case 2:
                cell.nameLabel.text = "Dhuhr"
                cell.timeLabel.text = formatter.string(from: prayingTime.dhuhr)
            case 3:
                cell.nameLabel.text = "Asr"
                cell.timeLabel.text = formatter.string(from: prayingTime.asr)
            case 4:
                cell.nameLabel.text = "Maghrib"
                cell.timeLabel.text = formatter.string(from: prayingTime.maghrib)
            default:
                cell.nameLabel.text = "Isha"
                cell.timeLabel.text = formatter.string(from: prayingTime.isha)
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
