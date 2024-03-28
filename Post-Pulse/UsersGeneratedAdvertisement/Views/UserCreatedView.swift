//
//  UserCreatedViews.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-21.
//

import SwiftUI

struct UserCreatedView: View {
    
    @ObservedObject var itemViewModel = ItemViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userOwnAdViewModel: UserOwnAdViewModel
    
    let currentUser: User2
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    ForEach(userOwnAdViewModel.getUserOwnAd) { item in
                        NavigationLink(destination: SellerAdvertisementView(item: item, user: currentUser).environmentObject(itemViewModel)) {
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
                                    VStack(alignment: .trailing) {
                                        Button {
                                            userOwnAdViewModel.deleteUserAd(itemId: item.id)
                                        } label: {
                                            Image(systemName: "xmark.bin")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding(5)
                                                .background(Color.red)
                                                .cornerRadius(5)
                                                .foregroundColor(Color.white)
                                                .padding(10)
                                        }
                                        
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
                                    }
                                )
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .gray, radius: 4, x: 4, y: 4)
                            .padding(7)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                        }
                    }
                }
            }
            .background(Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0))
        }
        .onAppear() {
            userOwnAdViewModel.fetchUsersOwnAd()
        }
    }
}

struct UserCreatedViews_Previews: PreviewProvider {
    static var previews: some View {
        UserCreatedView(currentUser: User2(id: "1", fullname: "Marko", email: "marko", employment: "marko", phoneNumber: "marko"))
            .environmentObject(UserOwnAdViewModel())
    }
}
