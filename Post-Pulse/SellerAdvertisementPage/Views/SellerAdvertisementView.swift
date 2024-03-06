//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct SellerAdvertisementView: View {
    
    let item: Item
    
    init(item: Item) {
        self.item = item
        
    }
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    ForEach(item.image.indices, id: \.self) { index in
                        GridImageView(index: index, item: item)
                    }
                }
                .cornerRadius(5)
                .padding(5)
                
                HStack() {
                    Text(item.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                    Text("\(item.price):-")
                        .fontWeight(.medium)
                        .lineLimit(2)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                Divider()
                    .background(Color.black)
                
                Text(item.description)
                    .background(Color.gray.opacity(0.3))
                    .frame(width: 350)
                    .padding(15)
                Divider()
                    .background(Color.black)
                
                SellerCardInfoView(item: item)
            }
            .padding()
        }
    }
}
    
    
    struct SellerAdvertisementView_Previews: PreviewProvider {
        static var previews: some View {
            SellerAdvertisementView(item: Item(user: User(nameOfUser: "John Doe", phoneNumber: "123456789", emailAddress: "john@example.com", employment: "Företag"), name: "Passat 2016", image: ["passat sido", "passat rear", "passat interior", "passat profile"], description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång", price: "999000", category: .fordon))
                .environmentObject(ItemViewModel())
        }
    }

