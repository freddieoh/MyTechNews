//
//  ViewController.swift
//  MyTechNews
//
//  Created by Fredrick Ohen on 2/6/17.
//  Copyright © 2017 geeoku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var articles: [Article]? = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchArticles()
    
  }
  
  func fetchArticles() {
    let url = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=49b8797ec37f4f3cb09e95563cb19338")!)
    
    URLSession.shared.dataTask(with: url) { (data,response,error) in
     
      self.articles = [Article]()
     
      do {
      let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
      
        if let articlesFromJSON = json?["articles"] as? [[String:Any]] {
          
          for articles in articlesFromJSON {
           
            let article = Article()
            
            
            if let title = articles["title"] as? String, let author = articles["author"] as? String, let desc = articles["description"] as? String, let url = articles["url"] as? String, let urlToImage = articles["urlToImage"] as? String {
              
              article.author = author
              article.headline = title
              article.desc = desc
              article.url = url
              article.imageURL = urlToImage
              }
              
              self.articles?.append(article)
                }
              }
          } catch let error {
            print(error)
        }
    }.resume()
  }

}


// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
  
}


// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
    cell.articleTitleLabel.text = self.articles?[indexPath.row].headline
    cell.articleDescriptionLabel.text = self.articles?[indexPath.row].description
    

    return cell
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articles?.count ?? 0
  }
  
}
