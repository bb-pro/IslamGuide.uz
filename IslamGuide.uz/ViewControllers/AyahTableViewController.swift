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
    @IBOutlet var playButton: UIButton!
    @IBOutlet var restartButton: UIButton!
    
    var ayahs: [Ayah] = []
    var arabicAyahs: [Ayah] = []
    
    private let networkManager = NetworkManager.shared
    private let audioPlayerManager = AudioPlayerManager.shared
    private var currentIndex = 0
    private var selectedCell: IndexPath!
    private var isAudioStarted = false
    private var isAudioPaused = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 800
    }
    
    @IBAction func playButtonPressed() {
        if !isAudioStarted && isAudioPaused {
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            isAudioStarted = true
            isAudioPaused = false
            playNextAyah()
        } else if isAudioStarted && !isAudioPaused {
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
            isAudioStarted = false
            audioPlayerManager.player?.pause()
        } else {
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            isAudioStarted = true
            isAudioPaused = false
            audioPlayerManager.player?.play()
        }
    }
    
    @IBAction func restartButtonPressed() {
        
        audioPlayerManager.player?.seek(to: .zero)
        audioPlayerManager.player?.replaceCurrentItem(with: nil)
        currentIndex = 0
        playNextAyah()
    }
}

// MARK: - Table view data source
extension AyahTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        selectedCell = indexPath
    }
}

//MARK: - Networking and AudioPlaying
private extension AyahTableViewController {
    func playNextAyah() {
        print(ayahs.count)
        guard currentIndex < ayahs.count else {
            print("Finished playing all Ayahs.")
            tableView.deselectRow(at: IndexPath(row: currentIndex, section: 0), animated: true)
            return
        }
        
        // Selecting the cell that is being played
        let indexPath = IndexPath(row: currentIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        
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
        
        // Observe AVPlayerItemDidPlayToEndTime notification
        NotificationCenter.default.addObserver(self, selector: #selector(ayahDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        audioPlayerManager.player = AVPlayer(playerItem: playerItem)
        audioPlayerManager.player?.play()
        print("Playing Ayah: \(currentAyah.text)")
        currentIndex += 1
    }
    
    @objc func ayahDidFinishPlaying(_ notification: Notification) {
        // Remove the observer
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        // Wait for a short delay before playing the next Ayah
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.playNextAyah()
        }
    }
}
