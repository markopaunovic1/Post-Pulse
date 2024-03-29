
import SwiftUI

struct CategoryItemView: View {
    
    @ObservedObject var viewModel: ItemViewModel
    @State var categoryIsPressed = true
    
    let categories = ["Fordon", "Elektronik", "Hushål", "Fritid & Hobby", "Instrument", "Kläder", "Bostad", "Personligt", "Jobb", "Övrigt"]
    
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        viewModel.getAllAdsByCategory(forCategory: category)
                    }) {
                        Text(category)
                            .padding(15)
                            .background(Color(red: 14.0/255.0, green: 33.0/255.0, blue: 61.0/255.0))
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .cornerRadius(25)
                    }
                }
            }
            .padding(.leading, 15)
        }
        .shadow(color: .gray, radius: 4, x: 4, y: 4)
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
