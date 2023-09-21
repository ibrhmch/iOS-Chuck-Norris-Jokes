import SwiftUI

class JokeViewModel: ObservableObject {
    @Published var joke: String = " .. loading .."

    func fetchJoke(category: String) async {
        joke = await getRandomJoke(category: category) ?? ""
    }
}
