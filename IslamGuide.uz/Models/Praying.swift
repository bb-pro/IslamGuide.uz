//
//  PrayingTime.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 13/04/23.
//

import Foundation

struct Praying: Decodable {
    let city: String
    let date: String
    var today: PrayingTime
    var tomorrow: PrayingTime
}

struct PrayingTime: Decodable {
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
    
    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case sunrise = "Sunrise"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case maghrib = "Maghrib"
        case isha = "Isha'a"
    }
}


