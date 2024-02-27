//
//  SwiftUIView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-23.
//

import SwiftUI

struct ItemView: View {
    
    struct Item {
            let name: String
            let image: [String]
            let price: String
        let typeOfItem: String
        }
    
    let items = [
    
        TheItems(name: "PASSAT 2016",
                 image: ["passat sido", "passat rear", "passat interior", "passat profile"],
                 price: "1000000",
                 typeOfItem: "Fordon"),
        
        TheItems(name: "Guitar",
                 image: ["guitar side", "guitar back", "guitar close front"],
                 price: "2299",
                 typeOfItem: "Fritid & Hobby")
    ]
        
    var body: some View {
            ScrollView {
                ForEach(items, id: \.name) { item in
                    VStack {
                        TabView {
                            ForEach(item.image, id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(width: 360 ,height: 200)
                        .overlay(
                            
                            HStack(spacing: 0) {
                                Text(item.name)
                                    .fontWeight(.none)
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(8)
                                    .padding(.leading, 4)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .background(Color(white: 0.4, opacity: 0.7))
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                
                                Text("\(item.price):-")
                                    .fontWeight(.none)
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(8)
                                    .padding(.trailing, 4)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .background(Color(white: 0.4, opacity: 0.7))
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                            }
                        )
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4)
                    .padding()
                }
            }
        }
    }

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
