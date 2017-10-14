//
//  DownloadableImageView.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 14..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

let imageCache: NSCache<NSString, UIImage> = NSCache()

class DownloadableImageView: UIImageView {
  var imageUrl: String = "" {
    didSet { loadImage(from: imageUrl) }
  }
  
  private func loadImage(from: String) {
    guard let url = URL(string: from) else { return }
    
    if let imageFromCache = imageCache.object(forKey: from as NSString) {
      self.image = imageFromCache
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      guard error == nil else {
        print(error as Any)
        return
      }
      
      DispatchQueue.main.async(execute: {
        let imageData = UIImage(data: data!)
        self.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
          self.image = imageData
          self.alpha = 1
        })
        if let img = imageData { imageCache.setObject(img, forKey: from as NSString) }
      })
    }).resume()
  }
  
}

