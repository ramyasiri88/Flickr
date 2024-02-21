//
//  DetailViewModelTests.swift
//  FlickrTests
//
//  Created by Ramya Siripurapu on 2/20/24.
//

import XCTest
@testable import Flickr

final class ItemDetailViewModelTests: XCTestCase {
    
    func testParseDescription() {
        let item = Item(id: UUID(), title: Optional("Poutanes"), link: Optional("https://www.flickr.com/photos/detesenka/53518704012/"), media: Optional(Flickr.Media(m: Optional("https://live.staticflickr.com/65535/53518704012_3a95ba8772_m.jpg"))), dateTaken: nil, description: "<p>This is a <b>test</b> description.</p>", published: Optional("2024-02-10T00:41:47Z"), author: Optional("nobody@flickr.com (\"DeteSenka\")"), authorID: nil, tags: Optional("tshirt problems bye manequin"))
        let viewModel = ItemDetailViewModel(item: item)
        
    
        viewModel.parseDescription()
        XCTAssertEqual(viewModel.description, "This is a test description.")
    }
    
}
