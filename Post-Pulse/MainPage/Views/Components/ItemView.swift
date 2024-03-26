//
//  SwiftUIView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-23.
//

import SwiftUI

struct ItemView: View {
    
    @ObservedObject var itemViewModel = ItemViewModel()
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var SelectedCategory: String?
    @State private var sortByDate = false
    @State private var orderOptions = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(searchText: $itemViewModel.searchText)
                    
                    CategoryItemView(selectedCategory: $SelectedCategory)
                    
                    Menu("Sortera: \(itemViewModel.selectedOrder?.rawValue ?? "")") {
                        ForEach(ItemViewModel.SortOptions.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                Task {
                                    itemViewModel.sortSelected(option: option)
                                }
                            }
                        }
                    }
                    .padding(5)
                    .frame(width: 370, height: 30)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
                    
                    
                    ForEach(itemViewModel.filteredItems, id: \.self) { item in
                        NavigationLink(destination: SellerAdvertisementView(item: item, user: User2(id: item.id, fullname: item.fullname, email: item.email, employment: item.employment, phoneNumber: item.phoneNumber)).environmentObject(itemViewModel)) {
                            VStack {
                                TabView {
                                    ForEach(item.imageURL, id: \.self) { imageName in
                                        let imageURL = URL(string: imageName) ?? URL(string: "")
                                        
                                        AsyncImage(url: imageURL) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .frame(width: 360, height: 200)
                                .overlay(
                                    VStack {
                                        Image(systemName: "")
                                        
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
                                            Divider()
                                        }
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
        .onAppear() {
                itemViewModel.fetchItems()
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
