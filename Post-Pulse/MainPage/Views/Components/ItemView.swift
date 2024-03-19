//
//  SwiftUIView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-23.
//

import SwiftUI

struct ItemView: View {
    
    @ObservedObject var itemViewModel = ItemViewModel()
    @State private var SelectedCategory: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(searchText: $itemViewModel.searchText)
                    
                    CategoryItemView(selectedCategory: $SelectedCategory)
                    
                    ForEach(itemViewModel.filteredItems) { item in
                        NavigationLink(destination: SellerAdvertisementView(item: item).environmentObject(itemViewModel)) {
                            VStack {
                                TabView {
                                    ForEach(item.image, id: \.self) { imageName in
                                        Image(imageName)
                                            .resizable()
                                            .scaledToFill()
                                    }
                                }
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .frame(width: 360, height: 200)
                                .overlay(
                                    HStack(spacing: 0) {
                                        Text(item.itemName)
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
                            .padding(7)
                        }
                    }
                }
            }
            .background(Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0))
        }
    }
    
    init() {
        itemViewModel.fetchItems()
    }
    
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
