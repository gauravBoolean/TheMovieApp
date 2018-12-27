//
//  UIComponants.swift
//  TheMovieApp
//
//  Created by superoot on 24/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

let moviePosterImageCache = NSCache<NSString, UIImage>()


class MoviePosterCollectionViewCell : UICollectionViewCell{
    
    
    let imgMoviePoster : CustomAsyncImageView = {
        let img = CustomAsyncImageView()        
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "imgPlaceholder")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    let lblTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white 
        return label
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(imgMoviePoster)
        
        
        
        NSLayoutConstraint.activate([
            imgMoviePoster.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            //imgWithBadge.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            //imgWithBadge.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            imgMoviePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
//            imgMoviePoster.widthAnchor.constraint(equalToConstant: 60),
//            imgMoviePoster.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            
            lblTitle.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 2),
            lblTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -2),
            lblTitle.topAnchor.constraint(equalTo: self.imgMoviePoster.bottomAnchor, constant: 0),
            lblTitle.heightAnchor.constraint(equalToConstant: 30),
            lblTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
            ])
        
        
        
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


class CustomAsyncImageView : UIImageView{
    var currentUrlString : String?
    
    func loanAsyncImage(urlString : String){
        currentUrlString = urlString
        if let img = moviePosterImageCache.object(forKey: urlString as NSString){
            self.image = img
            return
        }
        
        loadImageData(urlString: urlString){ img in
            if self.currentUrlString == urlString{
                self.image = img
            }
            moviePosterImageCache.setObject(img, forKey: urlString as NSString)
        }
    }
    
}
