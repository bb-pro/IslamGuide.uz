//
//  LanguageOptions.swift
//  Islam Guide
//
//  Created by Bektemur Mamashayev on 26/05/23.
//

import Foundation

final class LanguageOptions {
    static let shared = LanguageOptions()
    
    let languages = ["English", "Uzbek", "Russan"]
    private init() {}
}
