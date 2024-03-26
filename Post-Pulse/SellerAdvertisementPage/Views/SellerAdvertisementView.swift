//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct SellerAdvertisementView: View {
    
    @EnvironmentObject var itemViewModel: ItemViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let item: Item2
    let user: User2
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                    ForEach(item.imageURL.indices, id: \.self) { index in
                        GridImageView(index: index, item: item)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        if authViewModel.userSession != nil {
                            Button("Lägg till favoriter +") {
                                Task {
                                    favoriteViewModel.addFavoriteItemToUser(userId: user.id, itemId: item.id)
                                }
                            }
                            .backgroundStyle(Color.white)
                            .foregroundColor(Color.black)
                        } else {
                            EmptyView()
                        }
                    }
                }
                .cornerRadius(5)
                .shadow(color: .gray, radius: 6, x: 3, y: 4)
                
                Divider()
                
                HStack {
                    Text(item.itemName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                    Text("\(item.price):-")
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
                .padding(10)
                .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 3, y: 4)
                
                Divider()
                VStack {
                    Text("Inlagd: \(item.dateCreated)")
                        .frame(width: 330, alignment: .trailing)
                        .padding(.bottom, 1)
                        .frame(alignment: .trailing)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    Text(item.description)
                }
                .padding(10)
                .frame(width: 370, alignment: .leading)
                .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 3, y: 4)
                
                Divider()
                    SellerCardInfoView(item: item)
                
            }
            .padding()
        }
        .overlay(
            ZStack {
                if itemViewModel.showImageViewer {
                    ImageView(item: item)
                }
            }
        )
        .background(Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0))
    }
}


struct SellerAdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        SellerAdvertisementView(item: Item2(id: "1", itemName: "Tesla model X", imageURL: ["Bilder"], description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since themore recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", price: 20, category: "fordon", dateCreated: "26 mars 16:31", userId: "userid", fullname: "Marko Paunovic", email: "marko@gmail.com", employment: "Företag", phoneNumber: "0766666666"), user: User2(id: "id", fullname: "fullname", email: "email", employment: "employment", phoneNumber: "07666"))
            .environmentObject(AuthViewModel())
            .environmentObject(ItemViewModel())
    }
}

