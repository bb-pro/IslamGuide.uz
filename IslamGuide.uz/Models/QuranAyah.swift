//
//  QuranAyah.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 05/04/23.
//

import Foundation


struct QuranAyah: Decodable {
    let code: Int
    let status: String
    let data: Ayah
}

struct Ayah: Decodable {
    let number: Int
    let text: String
}
