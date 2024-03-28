
import SwiftUI
struct MainPageView: View {
    
    @State private var showSearchResultView = false
    
    var body: some View {
        
        ZStack {
            VStack{
                ItemView()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView().environmentObject(ItemViewModel())
        ContentView()
    }
}
