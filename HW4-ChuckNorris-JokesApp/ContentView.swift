//
//  ContentView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI

struct ContentView: View {
    @State var name: String = "John"
    @State var showHello: Bool = false
    @State var backgroundColor: Color = Color.white
    @State var explicitCategoryAllowed: Bool = true
    
    var body: some View {
        TabView {
            CategoriesNewView(backgroundColor: $backgroundColor, explicitCategoryAllowed: $explicitCategoryAllowed)
                .tabItem{
                    Label("Jokes", systemImage: "house")
            }
            
            JokesSearchView()
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
            }
            
            Settings(backgroundColor: $backgroundColor, explicitAllowed: $explicitCategoryAllowed)
                .tabItem{
                    Label("Settings",
                    systemImage: "gearshape")
                    }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
