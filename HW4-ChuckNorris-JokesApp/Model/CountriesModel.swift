//
//  CountriesModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import Foundation
import MapKit

struct Country: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var capitalInfo: CountryInfo
    var flag: String
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct CountryInfo: Codable {
    var latlng: [Double]?
    
    var coordinates: CLLocationCoordinate2D? {
        guard let latlng, latlng.count >= 2 else { return nil }
        return CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
    }
}

