//
//  MapJokeViewModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import Foundation

class MapJokeViewModel: ObservableObject {
    @Published var countries = [Country]()
    
    @MainActor
    func getAllCountries() -> () {
        Task{
            do {
                let url = URL(string: "https://restcountries.com/v3.1/all")!
                let (data, _) = try await URLSession.shared.data(from: url)
                self.countries = try JSONDecoder().decode([Country].self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
