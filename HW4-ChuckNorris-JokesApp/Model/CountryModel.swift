//
//  CountryModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import Foundation
import MapKit

struct Country: Codable, Identifiable{
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var latlng: Array<Double>?
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latlng, latlng.count >= 2 else { return nil }
        return CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
    }
    
    init(){
        self.name = CountryName()
    }
    
}

struct CountryName: Codable{
    var common: String
    var official: String
    
    init(){
        self.common = "temp"
        self.official = "temp"
    }
    
}
