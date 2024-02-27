//
//  SwiftUIView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import SwiftUI
struct MainPageView: View {
    
    @EnvironmentObject var vm: SearchBarViewModel
    
    var body: some View {
        SearchBarView(searchText: $vm.searchText)
        CategoryItemView()
        ItemView()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView().environmentObject(SearchBarViewModel())
        ItemView()
    }
}
