//
//  HomeViewModel.swift
//  Flickr
//
//  Created by Ramya Siripurapu on 02/19/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    var cancellebles = Set<AnyCancellable>()
    var textCancellebles = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var items: [Item] = [Item]()
    
    init() {
        self.searchFieldListener()
    }
    
    func searchFieldListener() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { text in
                if !text.isEmpty{
                    self.callAPI(text: self.searchText)
                }
            }.store(in: &textCancellebles)
    }
    
    func callAPI(text: String) {
        let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
        let url = baseURL + text
        guard let URL = URL(string: url) else {return}
        fetch(from: URL)
    }
    
    
    
    func fetch(from url: URL) {
        cancellebles.removeAll()
        isLoading = true
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
        
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let flickrData = try decoder.decode(Res.self, from: data)
                if let items = flickrData.items {
                    DispatchQueue.main.async {
                        self.items = items
                        self.isLoading = false
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}
