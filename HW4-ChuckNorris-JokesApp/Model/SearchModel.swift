//
//  SearchModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/28/23.
//

struct JokesResponse: Decodable {
    let total: Int
    let result: [JokesResults]
    
    init(){
        let tempJoke = JokesResults()
        self.total = 0
        self.result = [tempJoke]
    }
}

struct JokesResults: Decodable, Identifiable {
    let id: String
    let value: String
    
    init(){
        self.id = "123"
        self.value = "Search for a Joke"
    }
}
