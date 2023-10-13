//
//  MapJokeViewModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import Foundation

class CountryJokeViewModel: ObservableObject{
    @Published var listOfCountries: [Country]
    @Published var countriesAreloaded = false
    
    init(){
        self.listOfCountries = [Country()]
    }
    
    @MainActor
    func setAllCountries() async {
        do {
            let url = URL(string: "https://restcountries.com/v3.1/all")!
            let (data, _) = try await URLSession.shared.data(from: url)
            self.listOfCountries = try JSONDecoder().decode([Country].self, from: data)
            self.countriesAreloaded = true
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
