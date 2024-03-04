//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct SellerAdvertisementView: View {
    
    @EnvironmentObject var data: ItemViewModel
    
    var items2: [Item] = showItem.items
    
    let item: Item
    
    init(item: Item) {
        self.item = item
                                            
    }
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        VStack(alignment: .center) {
            TabView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    ForEach(item.image, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .cornerRadius(5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: .infinity, height: 250)
            .padding(5)
            
            HStack(spacing: 200) {
                Text(item.name)
                    .fontWeight(.bold)
                Text("\(item.price):-")
                    .fontWeight(.bold)
                    
            }
            Divider()
                .background(Color.black)
            
            Text(item.description)
                .frame(width: 350)
                .padding(15)
            
            Divider()
                .background(Color.black)
        }
    }
    
    
    struct SellerAdvertisementView_Previews: PreviewProvider {
        static var previews: some View {
            SellerAdvertisementView(item: Item(name: "Passat 2016", image: ["passat sido", "passat rear", "passat interior", "passat profile"], description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång", price: "999000", category: .fordon))
                .environmentObject(ItemViewModel())
        }
    }
}
