//
//  NetworkManager.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchQuranData(completion: @escaping (Result<QuranSurah, Error>) -> Void) {
        let url = URL(string: "https://api.alquran.cloud/v1/surah")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                return
            }

            do {
                let quranResponse = try JSONDecoder().decode(QuranSurah.self, from: data)
    
                DispatchQueue.main.async {
                    completion(.success(quranResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
   


}
