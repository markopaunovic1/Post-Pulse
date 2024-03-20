//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct SellerAdvertisementView: View {
    
    @EnvironmentObject var theItem: ItemViewModel
    
    let item: Item2
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                    ForEach(item.imageURL.indices, id: \.self) { index in
                        GridImageView(index: index, item: item)
                    }
                }
                .cornerRadius(5)
                
                Divider()
            
                HStack() {
                    Text(item.itemName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                    Text("\(item.price):-")
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
                .padding(10)
                .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 3, y: 4)
                
                Divider()
                Text(item.description)
                    .padding(10)
                    .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 3, y: 4)
                Divider()
                
                SellerCardInfoView().environmentObject(AuthViewModel())
            }
            .padding()
        }
        .overlay(
            ZStack {
                if theItem.showImageViewer {
                    ImageView(item: item)
                }
            }
        )
        .background(Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0))
    }
}


struct SellerAdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        SellerAdvertisementView(item: Item2(id: UUID(), itemName: "Marko", imageURL: ["https://firebasestorage.googleapis.com:443/v0/b/post-pulse-52f96.appspot.com/o/images%2FB1059BD4-EC9A-4E1B-91AC-313249ED41EE.jpg?alt=media&token=95da230a-9770-4718-b6cc-ea4f5f0c09a3", "https://example.com/image2.jpg", "https://firebasestorage.googleapis.com:443/v0/b/post-pulse-52f96.appspot.com/o/images%2F2B97D72E-931F-4B80-8CF3-A2EF4778723D.jpg?alt=media&token=36816ceb-e1ea-4747-b5f5-4eabc1b6f8c9"], description: "asd", price: "123", category: .bostad))
            .environmentObject(ItemViewModel())
    }
}

