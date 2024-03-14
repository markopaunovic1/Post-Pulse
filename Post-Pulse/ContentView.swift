//
//  ContentView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-21.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            TabView {
                Group {
                    MainPageView().environmentObject(ItemViewModel())
                        .tabItem() {
                            Label("Hem", systemImage: "house")
                        }
                    
                    if authViewModel.userSession != nil {
                        
                        CreateAdvertisementView()
                            .tabItem() {
                                Label("Lägg till", systemImage: "plus.square")
                            }
                        
                        UserFavoriteAdView()
                            .tabItem() {
                                Label("Favoriter", systemImage: "heart.fill")
                            }
                        
                        UserView()
                            .tabItem() {
                                Label("Min Profil", systemImage: "person.crop.circle")
                            }
                        
                    } else {
                        LoginView()
                            .tabItem() {
                                Label("logga in", systemImage: "person.circle")
                            }
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
        ContentView().environmentObject(AuthViewModel())
    }
}
