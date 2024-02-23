//
//  SearchFunctionView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import SwiftUI
import Foundation

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.secondary : Color.black)
            
            TextField("Sök efter en produkt", text: $searchText)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.secondary)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        searchText = ""
                    }
                ,alignment: .trailing)
        }
        
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray,
                        radius:  10, x: 3, y: 6)
                .opacity(0.5)
        )
        .padding(.trailing, 50)
        .padding(.bottom, 10)
    }
}

struct SearchFunctionView_Previews: PreviewProvider {
    static var previews: some View {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
    }
}
