//
//  UIImageView+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, contentMode: UIImageView.ContentMode, borderColor: UIColor = .clear, borderWidth: CGFloat = 0) {
        self.init()
        self.image = image
        self.clipsToBounds = true
        self.contentMode = contentMode
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func loadImage(from url: URL) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        URLSession.shared.dataTask(with: request) { data, responce, error in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else if let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

