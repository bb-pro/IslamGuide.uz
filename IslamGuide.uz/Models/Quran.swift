//
//  Quran.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import Foundation
import Foundation

struct QuranSurah: Codable {
    let code: Int
    let status: String
    let data: [SurahData]
}

struct SurahData: Codable {
    let number: Int
    let name: String
    let englishName: String
    let englishNameTranslation: String
    let revelationType: String
}


