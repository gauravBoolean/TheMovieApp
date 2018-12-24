//
//  MasterViewController.swift
//  TheMovieApp
//
//  Created by superoot on 24/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

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
    
    var movieDataCollection = [String]()
    
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
        
        
    }
    
    func loadFalseData(){
        self.movieDataCollection = ["title 1", "title 2" , "title 3" , "title 4" , "title 5" , "title 6" , "title 7"]
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
        
        cellView.lblTitle.text = dataHolder
        
        cellView.backgroundColor = .blue
        
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
        
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



