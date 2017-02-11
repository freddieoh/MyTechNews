//
//  MenuManager.swift
//  MyTechNews
//
//  Created by Fredrick Ohen on 2/10/17.
//  Copyright © 2017 geeoku. All rights reserved.
//

import UIKit

class MenuManager: NSObject {
  
  let blackView = UIView()
  
  public func openMenu() {
    if let window = UIApplication.shared.keyWindow {
      blackView.frame = window.frame
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
      
      window.addSubview(blackView)
      
      UIView.animate(withDuration: 0.5, animations: {
        self.blackView.alpha = 1
      })
    }
  }
  
  public func dismissMenu() {
    UIView.animate(withDuration: 0.5) {
      
      self.blackView.alpha = 0
    }
  }
}

