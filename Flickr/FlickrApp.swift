//
//  FlickrApp.swift
//  Flickr
//
//  Created by Ramya Siripurapu on 02/19/24.
//

import SwiftUI

@main
struct FlickrApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
        }
    }
}
