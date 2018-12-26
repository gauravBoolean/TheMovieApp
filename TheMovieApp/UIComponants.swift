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
    
    
    let imgWithBadge : CustomAsyncImageView = {
        let img = CustomAsyncImageView()        
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    let lblTitle : UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.numberOfLines = 2
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return dateLabel
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(imgWithBadge)
        
        
        
        NSLayoutConstraint.activate([
            imgWithBadge.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            //imgWithBadge.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            //imgWithBadge.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            imgWithBadge.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            imgWithBadge.widthAnchor.constraint(equalToConstant: 60),
            imgWithBadge.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            
            lblTitle.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 2),
            lblTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -2),
            lblTitle.topAnchor.constraint(equalTo: self.imgWithBadge.bottomAnchor, constant: 0),
            //lblTitle.heightAnchor.constraint(equalToConstant: 30)
            lblTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
            ])
        
        //self.contentView.addRightBorder(color: TenoUIConstants.GRAY_LINE_COLOR, width: 1)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


class CustomAsyncImageView : UIImageView{
    var currentUrlString : String?
    
    func loanAsyncImage(urlString : String){
        currentUrlString = urlString
        
        image = nil
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
