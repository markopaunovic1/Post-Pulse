//
//  GridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-05.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var theItem: ItemViewModel
    
    let item: Item2
    let index: Int
    
    init(index: Int, item: Item2) {
        self.item = item
        self.index = index
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                theItem.selectedImageID = item.imageURL[index]
                theItem.showImageViewer.toggle()
                
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
        SellerAdvertisementView(item: Item2(id: UUID(), itemName: "Marko", imageURL: ["aasd"], description: "asd", price: "123", category: .bostad))
            .environmentObject(ItemViewModel())
    }
}


extension View {
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}
