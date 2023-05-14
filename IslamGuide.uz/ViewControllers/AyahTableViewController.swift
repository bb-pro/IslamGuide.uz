//
//  AyahTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 05/04/23.
//

import UIKit
import AVFAudio
import AVFoundation

final class AyahTableViewController: UITableViewController {
    var ayahs: [Ayah] = []
    var arabicAyahs: [Ayah] = []
    private let networkManager = NetworkManager.shared
    private var player: AVPlayer?
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 800
    }
}

// MARK: - Table view data source
extension AyahTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        currentIndex = indexPath.row
        playNextAyah()
    }
}

//MARK: - Networking and AudioPlaying
private extension AyahTableViewController {
    func playNextAyah() {
        guard currentIndex < ayahs.count else {
            print("Finished playing all Ayahs.")
            return
        }
        
        let currentAyah = ayahs[currentIndex]
        
        guard let urlString = arabicAyahs[currentIndex].audio else {
            currentIndex += 1
            playNextAyah()
            return
        }
        
        guard let audioURL = URL(string: urlString) else {
            currentIndex += 1
            playNextAyah()
            return
        }
        
        let playerItem = AVPlayerItem(url: audioURL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        
        print("Playing Ayah: \(currentAyah.text)")
        
        currentIndex += 1
        
        // Wait for the current Ayah to finish playing
        DispatchQueue.main.asyncAfter(deadline: .now() + playerItem.asset.duration.seconds) { [weak self] in
            self?.playNextAyah()
        }
    }
}
