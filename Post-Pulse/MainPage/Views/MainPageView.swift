//
//  SwiftUIView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import SwiftUI
struct MainPageView: View {
    
    @StateObject var vm = ItemViewModel()
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
        CategoryItemView(selectedCategory: .constant(""))
    }
}
