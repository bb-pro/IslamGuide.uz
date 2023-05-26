//
//  Extension + String.swift
//  Islam Guide
//
//  Created by Bektemur Mamashayev on 26/05/23.
//

import Foundation


extension String {

     func localize(comment: String = "") -> String {
         let defaultLanguage = "en"
         let value = NSLocalizedString(self, comment: comment)
         if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
             return value // String localization was found
         }

                 // Load resource for default language to be used as
         // the fallback language
         guard let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"), let bundle = Bundle(path: path) else {
             return value
         }

         return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
