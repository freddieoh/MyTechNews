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
  var source = "techcrunch"
  
  let menuManager = MenuManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchArticles(fromSource: source)
  }
  
  func fetchArticles(fromSource provider: String) {
    let url = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=\(provider)&sortBy=latest&apiKey=49b8797ec37f4f3cb09e95563cb19338")!)
    
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

        DispatchQueue.main.async {
          self.tableView.reloadData()
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
    cell.articleDescriptionLabel.text = self.articles?[indexPath.row].desc
    cell.articleAuthorLabel.text = self.articles?[indexPath.row].author
    cell.articleImageView?.downloadImage(from: (self.articles?[indexPath.row].imageURL!)!)
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articles?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewViewController
   
    webVC.url = self .articles?[indexPath.item].url
    
    self.present(webVC, animated: true, completion: nil)
  }
  
  @IBAction func menuButtonPressed(_ sender: Any) {
  
    menuManager.openMenu()
    menuManager.mainVC = self
  }
}

// MARK: UIImageView

extension UIImageView {
  
  func downloadImage(from url: String) {
    
    let url = URLRequest(url: URL(string: url)!)
    let task = URLSession.shared.dataTask(with: url) { (data,respone,error) in
      
      if error != nil {
        print(error.debugDescription)
        return
      }
      
      DispatchQueue.main.async {
        self.image = UIImage(data: data!)
      }
    }
    task.resume()
  }
}
