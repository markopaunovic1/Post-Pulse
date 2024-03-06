//
//  GridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-05.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var theItem: ItemViewModel
    let numberOfImagesToShow = 4

    let item: Item
    let index: Int
    
    init(index: Int, item: Item) {

        self.item = item
        self.index = index
    }
    
    var body: some View {
        ZStack {
            if index <= 3 {
                let imageName = item.image[index]
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (getRect().width - 20) / 2, height: 120)
            }
            
            let imageName = item.image
            if imageName.count > 4 && index == 3 {
                RoundedRectangle(cornerRadius: 5)
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
    
    
    
    struct GridImageView_Previews: PreviewProvider {
        static var previews: some View {
            SellerAdvertisementView(item: Item(name: "Passat 2016", image: ["passat sido", "passat rear", "passat interior", "passat profile", "passat seats", "passat rims"], description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång", price: "999000", category: .fordon))
                .environmentObject(ItemViewModel())
        }
    }


extension View {
  func getRect() -> CGRect {
    
      return UIScreen.main.bounds
  }
}
