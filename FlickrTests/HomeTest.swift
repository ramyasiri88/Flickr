//
//  HomeTest.swift
//  CVSTests
//
//  Created by Ramya Siripurapu on 02/19/24.
//

import XCTest

@testable import Flickr

final class ItemDetailsTest: XCTestCase {

    func testItemDetailDateConversion () {
        
        let item = Item(id: UUID(), title: Optional("Poutanes"), link: Optional("https://www.flickr.com/photos/detesenka/53518704012/"), media: Optional(Flickr.Media(m: Optional("https://live.staticflickr.com/65535/53518704012_3a95ba8772_m.jpg"))), dateTaken: nil, description: Optional(" <p><a href=\"https://www.flickr.com/people/detesenka/\">DeteSenka</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/detesenka/53518704012/\" title=\"Poutanes\"><img src=\"https://live.staticflickr.com/65535/53518704012_3a95ba8772_m.jpg\" width=\"240\" height=\"240\" alt=\"Poutanes\" /></a></p> "), published: Optional("2024-02-10T00:41:47Z"), author: Optional("nobody@flickr.com (\"DeteSenka\")"), authorID: nil, tags: Optional("tshirt problems bye manequin"))
        
        let view = ItemDetailView(detailViewModel: ItemDetailViewModel(item: item))
        
        let dateString = "2024-02-10T00:41:47Z"
        let answer = "Feb 9, 2024"
        let result = ItemDetailViewModel(item: item).$date.sink { res in
            XCTAssertEqual(answer, res)
        }
    }
}
