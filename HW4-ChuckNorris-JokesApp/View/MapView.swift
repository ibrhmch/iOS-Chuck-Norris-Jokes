//
//  MapJokeView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import SwiftUI

struct MapJokeView: View {
    @ObservedObject var mapJokeVM = MapJokeViewModel()
    
    var body: some View {
        VStack{
            if !mapJokeVM.countriesAreloaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            else{
                List(mapJokeVM.listOfCountries) { country in
                    Text(country.name.common)
                }
            }
        }
        .task {
            await mapJokeVM.setAllCountries()
        }
    }
}

#Preview {
    MapJokeView()
}
