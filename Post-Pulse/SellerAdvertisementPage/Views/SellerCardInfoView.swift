
import SwiftUI

struct SellerCardInfoView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var itemViewModel: ItemViewModel
    
    let item: Item
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 15, content: {
            VStack(alignment: .center, spacing: 10, content: {
                Text("Säljare: \(item.employment)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))
                
                Text("\(item.fullname)")
                    .fontWeight(.bold)
            })
            .padding(.trailing, 10)
            Divider()
            
            VStack(alignment: .center, spacing: 10) {
                
                Text("kontakt uppgifter:")
                    .foregroundColor(.secondary)
                    .font(.system(size: 14))
                
                Text("\(item.phoneNumber)")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.green)
                    .cornerRadius(10)
                
                Text("\(item.email)")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        })
        .padding(10)
        .frame(width: 370)
        .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 6, x: 3, y: 4)
        
        .onAppear() {
            itemViewModel.fetchItems()
        }
    }
}

struct SellerCardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
