    //
    //  HomeView.swift
    //  Flickr
    //
    //  Created by Ramya Siripurapu on 02/19/24.
    //

import SwiftUI
import NukeUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0){
                HStack{
                    TextField("Seach images", text: $viewModel.searchText)
                        .padding(10)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewModel.searchText.isEmpty ? Color.gray : Color.blue, lineWidth: 1)
                        )
                        .padding()
                        .accessibilityLabel("Search for images")
                }
                .overlay {
                    if viewModel.isLoading {
                        HStack{
                            Spacer()
                            ProgressView().padding(.horizontal).padding(.horizontal)
                        }
                        
                    }
                }
                
                Spacer()
                
                if !viewModel.items.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, content: {
                            ForEach(viewModel.items) { item in
                                NavigationLink {
                                    ItemDetailView(detailViewModel: ItemDetailViewModel(item: item))
                                } label: {
                                    LazyImage(url: URL(string: item.media?.m ?? ""))
                                        //LazyImage(source:item.media?.m ?? "")
                                        .cornerRadius(10)
                                        .accessibilityLabel("Image title: \(item.title ?? "")")
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: getScreenBounds().width / 2 - 20)
                                        .clipped()
                                        .cornerRadius(8)
                                        .accessibilityLabel("View details of \(item.title ?? "")")
                                }
                            }
                        })
                    }.padding(.horizontal)
                }
            }.background(Color.pink.opacity(0.1))
                .environment(\.sizeCategory, .large)
                .navigationTitle("Flickr")
        }
    }
}
extension View {
    func getScreenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}
struct ImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURLString: String
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage(systemName: "photo")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: getScreenBounds().width / 2 - 20)
            .clipped()
            .onAppear {
                imageLoader.loadImage(from: URL(string: imageURLString)!)
            }
    }
}
#Preview {
    HomeView()
}
