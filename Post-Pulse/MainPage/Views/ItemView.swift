//
//  SwiftUIView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-23.
//

import SwiftUI

struct ItemView: View {
    let images = ["passat sido", "passat rear", "passat interior", "passat profile"]
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                TabView {
                    ForEach(0..<4) { i in
                        Image("\(images[i])").resizable()
                    }
                }
                
                .frame(width: 360, height: 200)
                .scaledToFit()
                .cornerRadius(15)
                .overlay(ImageOverlay())
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct ImageOverlay: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Passat 2016 ")
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(Color(white: 0.4, opacity: 0.7))
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            Text("99 900:-")
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(5)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(Color(white: 0.4, opacity: 0.7))
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .opacity(0.8)
        .cornerRadius(15.0)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
