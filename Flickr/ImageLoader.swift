//
//  ImageLoader.swift
//  Flickr
//
//  Created by Ramya Siripurapu on 02/19/24.
//

import Foundation
import UIKit
import Combine

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?

    private var cancellable: AnyCancellable?

    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
