//
//  NetworkManager.swift
//  RandomInsultGenerator
//
//  Created by Bulat Kamalov on 11.11.2021.
//

import Foundation


import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

    private init() {}

    func fetchInsult(from url: String?, with completion: @escaping(FuckYouElements) -> Void) {
        guard let url = URL(string: url ?? "oi" ) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                print(error)
                print("Ищи ошибку")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let isult = try JSONDecoder().decode(FuckYouElements.self, from: data)
                DispatchQueue.main.async {
                    completion(isult)
                    print("Распарсил")
                }
                
            } catch let error {
                print(error.localizedDescription)
                print("Чтото пошло не так")
            }
        }.resume()
    }
}
