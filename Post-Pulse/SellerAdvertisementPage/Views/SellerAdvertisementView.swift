//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct SellerAdvertisementView: View {
    
    @EnvironmentObject var theItem: ItemViewModel
    
    let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
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
                    Text(item.name)
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
                
                SellerCardInfoView(item: item)
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
        SellerAdvertisementView(item: Item(user: User(nameOfUser: "John Doe", phoneNumber: "123456789", emailAddress: "john@example.com", employment: "Företag"), name: "Passat 2016", image: ["passat sido", "passat rear", "passat interior"], description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång", price: "999000", category: .fordon))
            .environmentObject(ItemViewModel())
    }
}

