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
    let today: PrayingTime
}

struct PrayingTime: Decodable {
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
}
