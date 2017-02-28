//
//  ArticleCell.swift
//  MyTechNews
//
//  Created by Fredrick Ohen on 2/6/17.
//  Copyright © 2017 geeoku. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
  
  @IBOutlet weak var articleImageView: UIImageView!
  @IBOutlet weak var articleTitleLabel: UILabel!
  @IBOutlet weak var articleDescriptionLabel: UILabel!
  @IBOutlet weak var articleAuthorLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
