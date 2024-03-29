
import SwiftUI

struct UserFavoriteAdView: View {
    
    @EnvironmentObject var itemViewModel: ItemViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        NavigationView {
            if favoriteViewModel.additionalData.isEmpty {
                ZStack {
                    Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0)
                        .ignoresSafeArea()
                    VStack {
                        Image(systemName: "heart.slash.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Inga favoriter har lagts till")
                    }
                }
            } else {
                ScrollView {
                    VStack {
                        ForEach(favoriteViewModel.additionalData) { item in
                            NavigationLink(destination: SellerAdvertisementView(item: item, user: User(id: "id", fullname: "fullname", email: "email", employment: "employment", phoneNumber: "076666666")).environmentObject(itemViewModel)) {
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
                                                    .scaledToFit()
                                            }
                                        }
                                    }
                                    .tabViewStyle(.page(indexDisplayMode: .never))
                                    .frame(width: 360, height: 200)
                                    .overlay(
                                        VStack(alignment: .trailing) {
                                            Button {
                                                favoriteViewModel.deleteUserFavoriteAd(itemId: item.id)
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
        }
        .onAppear() {
            favoriteViewModel.fetchUsersFavoriteAd()
        }
    }
}


struct UserFavoriteAdView_Previews: PreviewProvider {
    static var previews: some View {
        UserFavoriteAdView().environmentObject(FavoriteViewModel())
    }
}
