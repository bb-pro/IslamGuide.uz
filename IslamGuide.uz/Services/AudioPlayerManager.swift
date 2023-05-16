//
//  File.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 16/05/23.
//

import AVFoundation

final class AudioPlayerManager {
    static let shared = AudioPlayerManager()
    
    var player: AVPlayer?
    
    private init(player: AVPlayer? = nil) {
        self.player = player
    }
}
