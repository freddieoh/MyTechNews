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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }

}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
}


// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
    return cell
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
}
