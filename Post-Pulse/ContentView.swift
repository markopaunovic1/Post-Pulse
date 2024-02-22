//
//  ContentView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            MainPageView().environmentObject(SearchBarViewModel())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
