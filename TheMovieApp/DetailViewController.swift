//
//  DetailViewController.swift
//  TheMovieApp
//
//  Created by superoot on 24/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let posterImageView : UIImageView = {
        let img = UIImageView()        
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
   

    let lblMovieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()
    
    let lblPlotSynopsis : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()
    
    let lblUserRating : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()
    
    let lblReleaseDate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(posterImageView)
        view.addSubview(lblMovieTitle)
        view.addSubview(lblUserRating)
        view.addSubview(lblReleaseDate)
        view.addSubview(lblPlotSynopsis)
        
        NSLayoutConstraint.activate([
                posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                posterImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                posterImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                posterImageView.heightAnchor.constraint(equalToConstant: 200),
                
                
                lblMovieTitle.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
                lblMovieTitle.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                
                lblUserRating.topAnchor.constraint(equalTo: lblMovieTitle.bottomAnchor, constant: 10),
                lblUserRating.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                
                lblReleaseDate.topAnchor.constraint(equalTo: lblUserRating.bottomAnchor, constant: 10),
                lblReleaseDate.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                
                
                lblPlotSynopsis.topAnchor.constraint(equalTo: lblReleaseDate.bottomAnchor, constant: 10),
                lblPlotSynopsis.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                lblPlotSynopsis.rightAnchor.constraint(equalToSystemSpacingAfter: posterImageView.rightAnchor, multiplier: 0),
                
            ])
        
        lblMovieTitle.text = "hateful eight"
        lblReleaseDate.text = "19 aug 2019"
        lblUserRating.text = "4.5 star"
        lblPlotSynopsis.text = "sdjf dsiof idosjf sdiofj cosidf vsidh cvoidsj viosdj voisjd vosjmn vsdiojv svoisfjs isfhdnxvsiof cviowfskv iwfijssjfsjv isfdv9f hvhsd fcjsifsjfdisd"
        
        
        lblPlotSynopsis.sizeToFit()
    }

    
}

