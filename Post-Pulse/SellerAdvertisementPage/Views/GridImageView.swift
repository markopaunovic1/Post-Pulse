//
//  GridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-05.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var theItem: ItemViewModel


    let item: Item
    let index: Int
    
    init(index: Int, item: Item) {
        self.item = item
        self.index = index
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                theItem.selectedImageID = item.image[index]
                theItem.showImageViewer.toggle()
                
            }
        } label: {
            ZStack {
                if index <= 3 {
                    let imageName = item.image[index]
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth(index: index), height: 120)
                        .cornerRadius(0)
                }
                
                let imageName = item.image
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
        
        let imageName = item.image
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
            SellerAdvertisementView(item: Item(user: User(nameOfUser: "John Doe", phoneNumber: "123456789", emailAddress: "john@example.com", employment: "Privat"), name: "Passat 2016", image: ["passat profile", "passat seats", "passat rim", "passat sido", "passat rear"], description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång", price: "999000", category: .fordon))
                .environmentObject(ItemViewModel())
        }
    }


extension View {
  func getRect() -> CGRect {
    
      return UIScreen.main.bounds
  }
}
