//
//  Quran.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//
import Foundation

struct QuranResponse: Codable {
    let code: Int
    let status: String
    let data: QuranData
}

struct QuranData: Codable {
    let surahs: [Surah]
}

struct Surah: Codable {
    let number: Int
    let name: String
    let englishName: String
    let englishNameTranslation: String
    let revelationType: String
    let ayahs: [Ayah]
}
struct Ayah: Codable {
    let number: Int
    let audio: String?
    let text: String
    let numberInSurah: Int
    let juz: Int
    let manzil: Int
    let page: Int
    let ruku: Int
    let hizbQuarter: Int
}



