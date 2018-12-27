//
//  DetailViewController.swift
//  TheMovieApp
//
//  Created by superoot on 24/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let posterImageView : CustomAsyncImageView = {
        let img = CustomAsyncImageView()        
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "imgPlaceholder")
        return img
    }()
   

    let lblMovieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()
    
    let lblPlotSynopsis : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()
    
    let lblUserRating : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()
    
    let lblReleaseDate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1)
        return label
    }()

    let movie : Movie
 
    
    init(movie : Movie ) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(posterImageView)
        view.addSubview(lblMovieTitle)
        view.addSubview(lblUserRating)
        view.addSubview(lblReleaseDate)
        view.addSubview(lblPlotSynopsis)
        
        NSLayoutConstraint.activate([
                posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                posterImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                posterImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                posterImageView.heightAnchor.constraint(equalToConstant: 200),
                
                
                lblMovieTitle.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
                lblMovieTitle.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                lblMovieTitle.rightAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 0),
                
                lblUserRating.topAnchor.constraint(equalTo: lblMovieTitle.bottomAnchor, constant: 10),
                lblUserRating.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                
                lblReleaseDate.topAnchor.constraint(equalTo: lblUserRating.bottomAnchor, constant: 10),
                lblReleaseDate.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                
                
                lblPlotSynopsis.topAnchor.constraint(equalTo: lblReleaseDate.bottomAnchor, constant: 10),
                lblPlotSynopsis.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0),
                lblPlotSynopsis.rightAnchor.constraint(equalToSystemSpacingAfter: posterImageView.rightAnchor, multiplier: 0),
                
            ])
        
        lblMovieTitle.text = movie.originalTitle ?? ""
        lblReleaseDate.text = "Release Date : \(movie.releaseDate ?? "-/-")"
        lblUserRating.text = "Rating : \(movie.voteAverage ?? 0) \u{2606}"
        lblPlotSynopsis.text = "Plot : \n\(movie.overview ?? "")"
        posterImageView.loanAsyncImage(urlString: imageBaseUrl + (movie.posterPath ?? ""))
        
        lblPlotSynopsis.sizeToFit()
    }

    
}

