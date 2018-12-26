//
//  MasterViewController.swift
//  TheMovieApp
//
//  Created by superoot on 24/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit
import  Alamofire

class MasterViewController: UIViewController {

    var currentPageNumber : Int = 1
    
    
    let collectionView : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        flowLayout.scrollDirection = .vertical
        let collection  = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MoviePosterCollectionViewCell.self, forCellWithReuseIdentifier: "moiveCellIdenfire")
        return collection
    }()
    
    var movieDataCollection = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            ])
        loadFalseData()
        
        collectionView.backgroundColor = .green
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "search", style: .done, target: self, action: #selector(MasterViewController.searchClicked))
        
        fetchTrendingMovies()
        
    }
    
    @objc func searchClicked(){
        self.navigationItem.titleView = UISearchBar()
    }
    
    func loadFalseData(){
        
        
//        Movie(from: <#T##Decoder#>)
        
        
       // self.movieDataCollection = ["title 1", "title 2" , "title 3" , "title 4" , "title 5" , "title 6" , "title 7"]
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }

}

extension MasterViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieDataCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: "moiveCellIdenfire", for: indexPath) as! MoviePosterCollectionViewCell
        
        let dataHolder = self.movieDataCollection[indexPath.row]
        
        cellView.lblTitle.text = dataHolder.title
        
        cellView.backgroundColor = .red
        
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
//        self.navigationController?.pushViewController(DetailViewController(), animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let s = (collectionView.frame.width/4)
        let h : CGFloat = 100
        return CGSize(width: s, height: h)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
                self.currentPageNumber += 1
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
}


class CustomAsyncImageView : UIImageView{
    var currentUrlString : String?
    
    func loanAsyncImage(){
        
    }
    
}
