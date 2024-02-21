//
//  ItemDetailViewModel.swift
//  Flickr
//
//  Created by Ramya Siripurapu on 02/20/24.
//

import SwiftUI

class ItemDetailViewModel: ObservableObject {
    
    @Published var item: Item
    @Published var imageWidth: Int?
    @Published var imageHeight: Int?
    @Published var description: String?
    @Published var date: String?
    
    init(item: Item) {
        self.item = item
        parseDescription()
        parseImageSizeFromDescription()
        formattedDate()
    }
    
    func parseDescription() {
        guard let description = item.description else { return }
        let des = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.description = des
    }
    
    func parseImageSizeFromDescription() {
        guard let description = item.description else { return }
        
        let pattern = #"width="(\d+)"\s+height="(\d+)""#
        let regex = try! NSRegularExpression(pattern: pattern)
        
        let range = NSRange(location: 0, length: description.utf16.count)
        if let match = regex.firstMatch(in: description, options: [], range: range) {
            if let widthRange = Range(match.range(at: 1), in: description),
               let heightRange = Range(match.range(at: 2), in: description) {
                let width = Int(description[widthRange]) ?? 0
                let height = Int(description[heightRange]) ?? 0
                imageWidth = width
                imageHeight = height
            }
        }
    }
    
    func formattedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: item.published ?? "") {
            formatter.dateFormat = "MMM d, yyyy"
            self.date =  formatter.string(from: date)
        }
    }
    
}
