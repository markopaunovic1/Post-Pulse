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
                    ForEach(item.image.indices, id: \.self) { index in
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
                    ImageView(item: Item2(id: UUID(), itemName: "Marko", image: ["aasd"], description: "asd", price: "123", category: .bostad))
                }
            }
        )
        .background(Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0))
    }
}


struct SellerAdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        SellerAdvertisementView(item: Item2(id: UUID(), itemName: "Marko", image: ["aasd"], description: "asd", price: "123", category: .bostad))
            .environmentObject(ItemViewModel())
    }
}

