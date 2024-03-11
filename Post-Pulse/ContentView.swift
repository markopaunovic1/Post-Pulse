//
//  ContentView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-21.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        ZStack {
            TabView {
                Group {
                    MainPageView().environmentObject(ItemViewModel())
                        .tabItem() {
                            Label("Hem", systemImage: "house")
                        }
                    
                    LoginView()
                        .tabItem() {
                            Label("Lägg till", systemImage: "plus.square")
                        }
                    
                    LoginView()
                        .tabItem() {
                            Label("Favoriter", systemImage: "heart.fill")
                        }
                    
                    LoginView()
                        .tabItem() {
                            Label("Min Profil", systemImage: "person.crop.circle")
                        }
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color(red: 20/255, green: 30/255, blue: 61/255), for: .tabBar)
            }
            .onAppear() {
                
                UITabBar.appearance().backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 61/255, alpha: 1)
                                
            }
            .accentColor(Color(red: 252/255, green: 163/255, blue: 17/255))
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
