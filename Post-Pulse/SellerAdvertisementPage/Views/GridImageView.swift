//
//  GridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-05.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var itemViewModel: ItemViewModel
    
    let item: Item2
    let index: Int
    
    init(index: Int, item: Item2) {
        self.item = item
        self.index = index
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                itemViewModel.selectedImageID = item.imageURL[index]
                itemViewModel.showImageViewer.toggle()
                
            }
        } label: {
            ZStack {
                if index <= 3 {
                    let imageURL = URL(string: item.imageURL[index]) ?? URL(string: "")
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            // Placeholder or loading view
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getWidth(index: index), height: 120)
                                .cornerRadius(0)
                        case .failure(let error):
                            // Placeholder for failure
                            Text("Failed to load image \(error.localizedDescription)")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                let imageName = item.imageURL
                if imageName.count > 4 && index == 3 {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.black.opacity(0.5))
                    
                    let remainingImages = imageName.count - 4
                    Text("+\(remainingImages)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    func getWidth(index: Int)->CGFloat {
        
        let imageName = item.imageURL
        let width = getRect().width
        
        if imageName.count % 2 == 0 {
            return width / 2
            
        } else {
            if index == imageName.count - 1 {
                return width
                
            } else {
                return width / 2
            }
        }
    }
}



struct GridImageView_Previews: PreviewProvider {
    static var previews: some View {
        SellerAdvertisementView(item: Item2(id: UUID(), itemName: "Marko", imageURL: ["https://firebasestorage.googleapis.com:443/v0/b/post-pulse-52f96.appspot.com/o/images%2FB1059BD4-EC9A-4E1B-91AC-313249ED41EE.jpg?alt=media&token=95da230a-9770-4718-b6cc-ea4f5f0c09a3", "https://example.com/image2.jpg", "https://firebasestorage.googleapis.com:443/v0/b/post-pulse-52f96.appspot.com/o/images%2F2B97D72E-931F-4B80-8CF3-A2EF4778723D.jpg?alt=media&token=36816ceb-e1ea-4747-b5f5-4eabc1b6f8c9"], description: "asd", price: "123", category: .bostad))
            .environmentObject(ItemViewModel())
    }
}


extension View {
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}
