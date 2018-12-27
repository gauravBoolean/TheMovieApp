//
//  MasterViewController.swift
//  TheMovieApp
//
//  Created by superoot on 24/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit
import  Alamofire

enum MovieSortDescriptor {
    case POPULAR_ASC
    case POPULAR_DESC
    case RATING_HIGH
    case RATING_LOW
    
    
    func getSortDescriptor()-> ((Movie , Movie)->Bool){
        switch self {
        case .POPULAR_ASC:
            return {a , b in
                a.popularity ?? 0 < b.popularity ?? 0
            }
        case .POPULAR_DESC:
            return {a , b in
                a.popularity ?? 0 > b.popularity ?? 0
            }
        case .RATING_LOW:
            return {a , b in
                a.voteAverage ?? 0 < b.voteAverage ?? 0
            }
        case .RATING_HIGH:
            return {a , b in
                a.voteAverage ?? 0 > b.voteAverage ?? 0
            }
        }
    }
}

class MasterViewController: UIViewController {
    
    var currentPageNumber : Int = 1
    
    var currentSearchPageNumber : Int = 1
    
    let collectionView : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collection  = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MoviePosterCollectionViewCell.self, forCellWithReuseIdentifier: "moiveCellIdenfire")
        return collection
    }()
    
    var movieDataCollection = [Movie]()
    
    var searchMovieDataCollection = [Movie]()
    var isCurrentlySearching : Bool = false
    
    lazy var movieCellSize : CGSize = {
        let s = view.frame.width/4
        let h : CGFloat = view.frame.height/4.5
        return CGSize(width: s, height: h)
    }()

    
    var sortDescriptor : MovieSortDescriptor? {
        didSet{
            setSorting()
        }
    }
    
    var searchBar: UISearchBar?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            ])
       
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let btnSearch: UIBarButtonItem = UIBarButtonItem(title: "search", style: .done, target: self, action: #selector(MasterViewController.searchClicked))
       
        self.navigationItem.rightBarButtonItem = btnSearch
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(MasterViewController.sortClicked))
        
        fetchTrendingMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    @objc func searchClicked(){
        if isCurrentlySearching{
            self.searchMovieDataCollection.removeAll()
            self.searchBar?.removeFromSuperview()
            self.searchBar = nil
            self.navigationItem.rightBarButtonItem?.title = "Search"
            isCurrentlySearching = false
        }
        else{
            self.navigationItem.rightBarButtonItem?.title = "Cancel"
            self.searchBar  = UISearchBar()
            self.searchBar?.delegate = self
            self.navigationItem.titleView = self.searchBar
            isCurrentlySearching = true
        }
        self.collectionView.reloadData()
    }
    
    @objc func sortClicked(){
        let alertController = UIAlertController(title: "Sort", message: "please select", preferredStyle: .actionSheet)
        
        let popularAscAction = UIAlertAction(title: "most popular ", style: .default, handler: { _ in
            self.sortDescriptor = .POPULAR_DESC
        })
        
        let popularDescAction = UIAlertAction(title: "Least popular ", style: .default, handler: { _ in
            self.sortDescriptor = .POPULAR_ASC
        })
        
        let ratingAscAction = UIAlertAction(title: "Higest Rated ", style: .default, handler: { _ in
            self.sortDescriptor = .RATING_HIGH
        })
        
        let ratingDescAction = UIAlertAction(title: "Low Rated", style: .default, handler: { _ in
            self.sortDescriptor = .RATING_LOW
        })
        
        alertController.addAction(popularAscAction)
        alertController.addAction(popularDescAction)
        alertController.addAction(ratingAscAction)
        alertController.addAction(ratingDescAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setSorting(){
        if let sortD = sortDescriptor{
            if isCurrentlySearching{
                self.searchMovieDataCollection.sort(by: sortD.getSortDescriptor())
            }
            else{
                self.movieDataCollection.sort(by: sortD.getSortDescriptor())
            }
            self.collectionView.reloadData()
        }
        
    }

}

extension MasterViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isCurrentlySearching ?  self.searchMovieDataCollection.count : self.movieDataCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: "moiveCellIdenfire", for: indexPath) as! MoviePosterCollectionViewCell
        
        let dataHolder = isCurrentlySearching ? self.searchMovieDataCollection[indexPath.row] : self.movieDataCollection[indexPath.row]
        
        cellView.lblTitle.text = dataHolder.title
        let posterPath = imageBaseUrl + (dataHolder.posterPath ?? "")
        cellView.imgMoviePoster.loanAsyncImage(urlString: posterPath)
        cellView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
        return cellView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isCurrentlySearching{
            if indexPath.row == (self.searchMovieDataCollection.count - 1) {
                guard let searchText = self.searchBar?.text else{ return}
                fetchSearchMoviesResult(for: searchText)
            }
        }
        else{
            if indexPath.row == (self.movieDataCollection.count - 1) {
                fetchTrendingMovies()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieObj = isCurrentlySearching ? self.searchMovieDataCollection[indexPath.row] : self.movieDataCollection[indexPath.row]
        
        self.navigationController?.pushViewController(DetailViewController(movie: movieObj), animated: true)
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return movieCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MasterViewController :UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text{
            fetchSearchMoviesResult(for: searchString)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchMovieDataCollection.removeAll()
        self.currentSearchPageNumber = 1
    }
    
    
    func searchMovie(){
        
    }
}

extension MasterViewController {
    func fetchTrendingMovies(){
        let url = ServicePathLocator.trending.getUrl(with: ["movie" , "week"])
        let param : [String : AnyObject] = ["api_key" : "15686190614b58f74e62506048465097" as AnyObject , "page" : self.currentPageNumber as AnyObject]
        excuteRESTService(type: TrendingMovies.self, Alamofire.HTTPMethod.get, serviceUrl: url, param: param){
            trendingMovies  , err , status in
            
            if let resMovies = trendingMovies{
                self.movieDataCollection.append(contentsOf: resMovies.results)
                if let sortD = self.sortDescriptor{
                    self.movieDataCollection.sort(by: sortD.getSortDescriptor())
                    
                }
                self.currentPageNumber += 1
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
    
    
    func fetchSearchMoviesResult(for str : String){
        let url = ServicePathLocator.search.getUrl(with: [])
        let param : [String : AnyObject] = ["api_key" : "15686190614b58f74e62506048465097" as AnyObject ,"query" : str as AnyObject , "page" : self.currentPageNumber as AnyObject]
        excuteRESTService(type: TrendingMovies.self, Alamofire.HTTPMethod.get, serviceUrl: url, param: param){
            trendingMovies  , err , status in
            
            if let resMovies = trendingMovies{
                self.searchMovieDataCollection.append(contentsOf: resMovies.results)
                if let sortD = self.sortDescriptor{
                    self.searchMovieDataCollection.sort(by: sortD.getSortDescriptor())
                    
                }
                self.currentSearchPageNumber += 1
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
}




