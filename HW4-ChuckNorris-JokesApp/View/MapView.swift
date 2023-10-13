//
//  MapJokeView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var countryJokeViewModel = CountryJokeViewModel()
    var countriesWithCoordinates: [Country] {
        return countryJokeViewModel.listOfCountries.filter({ country in
            country.coordinate != nil
        })
    }
    
    var body: some View {
        VStack{
            if !countryJokeViewModel.countriesAreloaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            else{
                NavigationStack{
                    Map {
                        ForEach(countriesWithCoordinates) { country in
                            Annotation(country.name.common, coordinate: country.coordinate!) {
                                NavigationLink(destination: CountryJokeView(countryName: country.name.common)) {
                                    Image(systemName: "mappin")
                                        .foregroundColor(.white)
                                        .shadow(radius: 10)
                                }
                            }
                        }
                    }
                    .mapStyle(.imagery(elevation: .realistic))
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapScaleView()
                    }
                }
            }
        }
        .task {
            await countryJokeViewModel.setAllCountries()
        }
    }
}

#Preview {
    MapView()
}


//                NavigationStack{
//                    List(mapJokeVM.listOfCountries) { country in
//                        NavigationLink(destination: CountryJokeView(countryName: country.name.common)){
//                            Text(country.name.common)
//                        }
//                    }
//                }
