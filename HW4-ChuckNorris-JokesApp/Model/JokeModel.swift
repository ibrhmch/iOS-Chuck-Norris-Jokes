import SwiftUI

struct Joke: Codable {
    let icon_url: String
    let id: String
    let url: String
    let value: String
}


func getRandomJoke(category: String = "travel") async -> String? {
    do {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random?category=\(category)")!)
        let joke = try JSONDecoder().decode(Joke.self, from: data)
        return joke.value
    } catch {
        return nil
    }
}
