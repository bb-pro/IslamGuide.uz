//
//  NetworkManager.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/04/23.
//

import Foundation
import Alamofire

enum Link {
    case quranUz
    case quranAr
    case surah
    case ayah
    
    var url: URL {
        switch self {
            case .surah:
                return URL(string: "https://api.alquran.cloud/v1/surah")!
            case .ayah:
                return URL(string: "https://api.alquran.cloud/v1/ayah")!
            case .quranUz:
                return URL(string: "https://api.alquran.cloud/v1/quran/uz.sodik")!
            case .quranAr:
                return URL(string: "https://api.alquran.cloud/v1/quran/ar.alafasy")!
        }
    }
}

enum Edition: String {
    case english = "en.asad"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func playAudioFromAPI(apiURL: URL, completion: @escaping (Result<Data, Error>) -> Void) {
           AF.download(apiURL).responseData { response in
               switch response.result {
               case .success(let audioData):
                   completion(.success(audioData))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
   
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>)->Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
    
    
    
    func getData(for filePath: String, completion: @escaping(Result<QuranResponse, NetworkError>) -> Void) {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode(QuranResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }
    }
    
    
}
