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
    
    let item: Item2
    
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
        SellerAdvertisementView(item: Item2(id: UUID(), itemName: "Marko", image: ["aasd"], description: "asd", price: "123", category: .bostad))
            .environmentObject(ItemViewModel())
    }
}
