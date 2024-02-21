//
//  ResponseModel.swift
//  Flickr
//
//  Created by Ramya Siripurapu on 02/19/24.
//

import Foundation


    // MARK: - Res
struct Res: Codable {
    let title: String?
    let link: String?
    let description: String?
    let modified: String?
    let generator: String?
    let items: [Item]?
}

    // MARK: - Item
struct Item: Codable, Identifiable {
    var id = UUID()
    let title: String?
    let link: String?
    let media: Media?
    let dateTaken: String?
    let description: String?
    let published: String?
    let author: String?
    let authorID: String?
    let tags: String?
    
    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case description, published, author
        case authorID = "author_id"
        case tags
    }
}
struct Author: Codable {
    let email: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case username = "username"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let authorString = try container.decode(String.self)
        
        // Parse the author string into email and username
        let components = authorString.components(separatedBy: " (")
        guard components.count == 2 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid author string: \(authorString)")
        }
        
        self.email = String(components[0].dropFirst())
        self.username = String(components[1].dropLast())
    }
}


enum AuthorID: String, Codable {
    case the143205148N02 = "143205148@N02"
    case the197257559N05 = "197257559@N05"
    case the25792423N00 = "25792423@N00"
}

    // MARK: - Media
struct Media: Codable {
    let m: String?
}

