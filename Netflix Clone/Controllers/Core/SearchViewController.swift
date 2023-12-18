//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Hakan Türkmen on 17.12.2023.
//

import UIKit

class SearchViewController: UIViewController {

    
    private var titles : [Title] = []
    
    private let discoverTable : UITableView = {
       
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    
    private let searchController : UISearchController = {
       
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search For A Movie"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        discoverTable.delegate = self
        discoverTable.dataSource = self
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }
    
    
    func fetchDiscoverMovies(){
        APICaller.shared.getDiscoverMovies {result in
            switch result{
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async{
                    self.discoverTable.reloadData()
                }
            case.failure(let error):
                print(error)
        
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    


}


extension SearchViewController : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier , for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        
        
        cell.configure(with: TitleViewModel(titleName: titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "unkons", posterURL: titles[indexPath.row].poster_path ?? "unknown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_name ?? title.original_title else {return }
        
        APICaller.shared.getMovie(with: titleName ) {[weak self] result in
            switch result {
            case .success(let element):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeVideo: element, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc,animated: true)
                    
                }
                
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    
}

extension SearchViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        
        APICaller.shared.search(with: query) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    resultsController.titles = title
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
    }
    
    
}
