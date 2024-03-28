
import SwiftUI

struct SellerAdvertisementView: View {
    
    @EnvironmentObject var itemViewModel: ItemViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showingAlert = false
    
    let item: Item
    let user: User
    
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
                                showingAlert = true
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Klart!"), message: Text("Annonsen har lagts till i dina favoriter"), dismissButton: .default(Text("OK")))
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
        ContentView()
    }
}
