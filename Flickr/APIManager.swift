//
//  APIManager.swift
//  Flickr
//
//  Created by Ramya Siripurapu on 02/19/24.
//

import Foundation
import Combine

public struct APIManager {
    static let shared = APIManager()
    
    
    func publisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                
                guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                    throw URLError(URLError.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }

    
}
