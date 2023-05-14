//
//  AyahTableViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 05/04/23.
//

import UIKit
import AVFAudio
import AVFoundation

final class AyahTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var ayahs: [Ayah] = []
    var arabicAyahs: [Ayah] = []
    private let networkManager = NetworkManager.shared
    private var player: AVPlayer?
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 800
    }
    @IBAction func playButtonPressed() {
        playNextAyah()
    }
}

// MARK: - Table view data source
extension AyahTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ayahs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ayahCell", for: indexPath) as! AyahCell
        let ayah = ayahs[indexPath.row]
        cell.arabicLabel.text = arabicAyahs[indexPath.row].text
        cell.englishLabel.text = ayah.text
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AyahTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + playerItem.asset.duration.seconds + 1 ) { [weak self] in
            self?.playNextAyah()
        }
    }
}
