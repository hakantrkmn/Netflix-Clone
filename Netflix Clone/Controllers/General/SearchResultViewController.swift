//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Hakan Türkmen on 18.12.2023.
//

import UIKit

class SearchResultViewController: UIViewController {

    public var titles : [Title] = []
    
    public let searchResultsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    

}

extension SearchResultViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
        cell.configure(with: titles[indexPath.row].poster_path ?? "unknown")
        return cell
    }
    
  
    
    
}
