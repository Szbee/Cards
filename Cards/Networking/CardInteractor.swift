//
//  CardInteractor.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 23/09/2024.
//

import Foundation

protocol CardInteractorInput: AnyObject {
    func fetchData(completion: @escaping (Result<[CardResponse], Error>) -> Void)
}

class CardInteractor: CardInteractorInput {
    func fetchData(completion: @escaping (Result<[CardResponse], Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/wupdigital/interview-api/master/api/v1/cards.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data", code: 0, userInfo: nil)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let cardData = try JSONDecoder().decode([CardResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(cardData))
                }
            } catch let decodingError {
                DispatchQueue.main.async {
                    completion(.failure(decodingError))
                }
            }
        }.resume()
    }
}
