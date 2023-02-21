//
//  View.swift
//  Movi
//
//  Created by Muharrem Köroğlu on 13.02.2023.
//

import Foundation
import UIKit
import SDWebImage


protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update (with movies : PopularMovies)
    func update ()
    func makeAlert (title:String, message:String)
    
}

class CustomTableViewCell : UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private let moviePoster : UIImageView = {
        let moviePoster = UIImageView()
        moviePoster.sd_setImage(with: URL(string: ""))
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.clipsToBounds = true
        return moviePoster
    }()
    
    private let movieTitle : UILabel = {
       let movieTitle = UILabel()
        movieTitle.text = ""
        movieTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        movieTitle.textColor = .black
        movieTitle.numberOfLines = 3
        movieTitle.textAlignment = .left
        
        return movieTitle
    }()
    
    private let movieReleaseDate : UILabel = {
       let movieReleaseDate = UILabel()
        movieReleaseDate.text = ""
        movieReleaseDate.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        movieReleaseDate.textColor = .black
        movieReleaseDate.numberOfLines = 3
        movieReleaseDate.textAlignment = .left
        
        return movieReleaseDate
    }()
    
    private let icon : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "star.fill")
        icon.tintColor = .systemYellow
        return icon
    }()
    
    private let movieScore : UILabel = {
        let movieScore = UILabel()
        movieScore.text = ""
        movieScore.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        movieScore.textColor = .systemYellow
        movieScore.textAlignment = .center
        return movieScore
    }()
    
    private let seperator : UIView = {
        let seperator = UIView()
        seperator.backgroundColor = .black
        seperator.tintColor = .black
        return seperator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(moviePoster)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieScore)
        contentView.addSubview(icon)
        contentView.addSubview(movieReleaseDate)
        contentView.addSubview(seperator)
        contentView.backgroundColor = .systemGray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviePoster.frame = CGRect(x: 5, y: 5, width: 120, height: contentView.frame.size.height - 5)
        movieScore.frame = CGRect(x: 40 + moviePoster.frame.size.width, y: contentView.frame.size.width - movieTitle.frame.size.height + 5, width: contentView.frame.size.width - 10 - moviePoster.frame.size.width - movieTitle.frame.size.width, height: contentView.frame.size.height)
        icon.frame = CGRect(x: 25 + moviePoster.frame.size.width - 10, y: contentView.frame.size.width - movieTitle.frame.size.height + 90, width: 28, height: 25)
        movieTitle.frame = CGRect(x: 20 + moviePoster.frame.size.width, y: contentView.frame.size.height - 360, width: contentView.frame.size.width - 200, height: contentView.frame.size.width)
        movieReleaseDate.frame = CGRect(x: 20 + moviePoster.frame.size.width, y: contentView.frame.size.height - 230, width: contentView.frame.size.width - 200, height: contentView.frame.size.width)
        seperator.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 10)
    }
    
    public func configure (moviePostUrl : String, movieTitle : String, movieScore : String, moviReleaseDate : String) {
        self.moviePoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(moviePostUrl)"))
        self.movieTitle.text = movieTitle
        self.movieScore.text = movieScore
        self.movieReleaseDate.text = moviReleaseDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MovieView : UIViewController, AnyView , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var presenter: AnyPresenter?
    
    var movies = [Results]()
    var filteredMovie = [Results]()
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.backgroundColor = .black
        table.isHidden = true
        return table
    }()
    
    private let indicator : UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white.withAlphaComponent(0.5)
        indicator.isHidden = false
        return indicator
    }()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        searchBar.backgroundColor = .white
        searchBar.showsCancelButton = true
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Search Movie", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(indicator)
        view.addSubview(searchBar)
        view.backgroundColor = .black
    
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height - 100)
        indicator.frame = CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50)
        searchBar.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 50)

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredMovie.removeAll()
        if searchText == "" {
            filteredMovie = movies
        }else {
            for movieNames in movies {
                if movieNames.title.lowercased().contains(searchText.lowercased()) {
                    filteredMovie.append(movieNames)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.filteredMovie = movies
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovie.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailRouter = MovieDetailRouter()
        MovieIdSingleton.sharedInstance.movieId = filteredMovie[indexPath.row].id
        self.present(detailRouter.startMovieDetail().movieDetailEntryPoint!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.backgroundColor = .black
        cell.layoutIfNeeded()
                
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectedBackgroundView

        cell.configure(moviePostUrl: filteredMovie[indexPath.row].poster_path, movieTitle: filteredMovie[indexPath.row].title, movieScore: "\(String(filteredMovie[indexPath.row].vote_average)) / 10", moviReleaseDate: "Release Date : \(filteredMovie[indexPath.row].formatted_release_date)")
        
        return cell
    }
    
    func update (with movie : PopularMovies) {
        DispatchQueue.main.async {
            self.movies = movie.results
            self.filteredMovie = self.movies
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func update () {
        DispatchQueue.main.async {
            self.movies = []
            self.tableView.isHidden = true
            self.indicator.isHidden = false
            self.searchBar.isHidden = true
            self.indicator.startAnimating()
        }
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
        alert.addAction(button)
        present(alert, animated: true)
    }
    
}

