//
//  ImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-07.
//

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var theItem: ItemViewModel
    @GestureState var draggingOffset: CGSize = .zero
    
    let item: Item
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(theItem.backGroundOpacity)
                .ignoresSafeArea()
            
            TabView(selection: $theItem.selectedImageID) {
                ForEach(item.image, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(y: theItem.imageViewerOffset.height)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .overlay(
                Button(action: {
                    withAnimation(.default) {
                        theItem.showImageViewer.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.white.opacity(0.35))
                        .clipShape(Circle())
                })
                .padding(10)
                ,alignment: .topTrailing
            )
        }
        .gesture(DragGesture().updating($draggingOffset, body: { (value, outValue, _) in
         
            outValue = value.translation
            theItem.onchange(value: draggingOffset)
            
        }).onEnded(theItem.onEnd(value:))
        )
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        SellerAdvertisementView(item: Item(user: User(nameOfUser: "John Doe", phoneNumber: "123456789", emailAddress: "john@example.com", employment: "Företag"), name: "Passat 2016", image: ["passat sido", "passat rear", "passat interior"], description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång", price: "999000", category: .fordon))
            .environmentObject(ItemViewModel())
    }
}
