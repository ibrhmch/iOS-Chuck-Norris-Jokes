import SwiftUI

class CategoriesViewModel: ObservableObject {
    @Published var categories: [String] = ["sport", "fashion"]
    @Published var isLoading: Bool = true

    func getChuckJokesCategories() async -> () {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/categories")!)
            categories = try JSONDecoder().decode([String].self, from: data)
        } catch {
            categories = ["sport", "fashion"]
        }
        isLoading = false
    }
}
