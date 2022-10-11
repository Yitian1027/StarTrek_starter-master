import Foundation
import Alamofire

class Parser {
  
  
  let urlString = "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc"

  func fetchRepositories(completionHandler: @escaping ([Repository]) -> Void) {
    AF.request(self.urlString).responseDecodable(of: Repositories.self) { (response) in
      guard let repositories: Repositories = response.value else { return }
      completionHandler(repositories.items)
    }
  }

}
