//
//  PrayingTimeViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 13/04/23.
//

import UIKit
import Adhan
import CoreLocation

final class PrayingTimeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let networkManager = NetworkManager.shared
    private let locationManager = CLLocationManager()
    
    private var prayingTime: PrayerTimes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        locationManager.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension PrayingTimeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            fetchData(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location did fail with error")
    }
}

//MARK: - Networking
private extension PrayingTimeViewController {
    func fetchData(lat: Double, lon: Double) {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: lat, longitude: lon)
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = .hanafi
        guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else { return }
        prayingTime = prayers
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension PrayingTimeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! PrayingTimeCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Hours and minutes format
        
        if prayingTime != nil {
            
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
        } else {
            return cell
        }
    }

}
//MARK: - UITableViewDelegate
extension PrayingTimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
