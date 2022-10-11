import SwiftUI

struct ContentView: View {
  
  // @ObservedObject instance of ViewModel
  
  // @State var searchField
  // @State var displayedRepos
  
  @ObservedObject var viewModel = ViewModel()
  @State var searchField: String = ""
  @State var displayedRepos = [Repository]()
  
  var body: some View {
    
    let binding = Binding<String>(get: {
      self.searchField
    }, set: {
      self.searchField = $0
      self.viewModel.search(searchText: self.searchField)
      self.displayRepos()
    })
    
    return NavigationView {
      VStack {
        TextField("Search", text: binding)
          .padding(.leading)
          .padding(.top, 5)
        List(displayedRepos) { repository in
          NavigationLink(
            destination: WebView(request: URLRequest(url:URL(string: repository.htmlURL)!))
              .navigationBarTitle(repository.name)) {
            RepositoryRow(repository: repository)
          }
        }.navigationBarTitle("Repos", displayMode: .inline)
        Spacer()
      }.onAppear(perform: loadData)
    }
    .navigationBarTitle("More languages", displayMode: .inline)
  }

  func loadData() {
    Parser().fetchRepositories { (repos) in
      self.viewModel.repos = repos
      self.displayedRepos = repos
    }
  }

  func displayRepos() {
    if searchField == "" {
      displayedRepos = viewModel.repos
    } else {
      displayedRepos = viewModel.filteredRepos
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
