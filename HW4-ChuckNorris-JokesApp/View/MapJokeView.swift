//
//  MapJokeView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import SwiftUI
import MapKit

struct MapJokeView: View {
    @ObservedObject var mapJokeVM: MapJokeViewModel
    
    var countriesWithCoordinates: [Country] {
        return self.mapJokeVM.countries.filter({
            country in country.capitalInfo.coordinates != nil
        })
    }
    
    var body: some View {
        Map {
            ForEach(countriesWithCoordinates) { country in
                Annotation(country.name.common, coordinate: country.capitalInfo.coordinates!) {
                    NavigationLink {
                        CountryJokeView(country: country.name.common)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .fill(.orange)
                            .frame(width: 20, height: 20)
                            .shadow(radius: 10)
                    }
                }
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
    }
}
