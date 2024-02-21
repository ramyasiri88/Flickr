    //
    //  ItemDetailView.swift
    //  Flickr
    //
    //  Created by Ramya Siripurapu on 02/19/24.
    //

import SwiftUI
import NukeUI
struct ItemDetailView: View {
    
    @ObservedObject var detailViewModel: ItemDetailViewModel
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                Group{
                    if let imageUrlString = detailViewModel.item.media?.m {
                        VStack(alignment: .center){
                            LazyImage(url: URL(string: imageUrlString))
                                .cornerRadius(10)
                                .accessibilityLabel("Image title: \(detailViewModel.item.title ?? "")")
                        }
                    }
                }
                
                HStack{
                    Text(detailViewModel.item.title ?? "")
                        .font(.system(size: UIFont.textStyleSize(.title2), weight: .medium))
                        .padding(.vertical)
                    Spacer()
                    Button(action: {
                        shareItem()
                    }) {
                        Text("Share")
                            .font(.subheadline)
                            .padding(8)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                Text(detailViewModel.description ?? "")
                    .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                Divider()
                Text("Author: \(detailViewModel.item.author ?? "")")
                    .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                
                if let publishedDate = detailViewModel.date {
                    Text("Published Date: \(publishedDate)")
                        .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                    
                    Divider()
                    
                    Text("Image Size: \(detailViewModel.imageWidth ?? 0) x \(detailViewModel.imageHeight ?? 0)")
                        .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                    
                }
                Spacer()
            }.padding()
            
            .environment(\.sizeCategory, .large)
            .navigationTitle("Detail View")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color.pink.opacity(0.1))
        
        
    }
    func shareItem() {
        guard let imageUrlString = detailViewModel.item.media?.m,
              let imageUrl = URL(string: imageUrlString) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            let activityItems: [Any] = [image, detailViewModel.item.title ?? ""]
            
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                UIApplication.shared.keyWindow?.rootViewController?
                    .present(activityViewController, animated: true, completion: nil)
            }
        }.resume()
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
            // Get connected scenes
        return self.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

public extension UIFont {
    static func textStyleSize(_ style: UIFont.TextStyle) -> CGFloat {
        UIFont.preferredFont(forTextStyle: style).pointSize
    }
}
