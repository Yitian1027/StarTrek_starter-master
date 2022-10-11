import Foundation

class ViewModel: ObservableObject {
  
  // instance of parser
  
  // MARK: Fields
  // var repos
  // var searchText
  // var filteredRepos
  @Published var searchText: String = ""
  @Published var repos: [Repository] = []
  @Published var filteredRepos: [Repository] = []

  
  // MARK: Methods
  func search(searchText: String) {
    self.filteredRepos = self.repos.filter { repo in
      return repo.name.lowercased().contains(searchText.lowercased())
    }
  }
}
