//
//  MoviesListViewController.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import UIKit
import RxSwift
import RxCocoa
import FaveButton

class MoviesListViewController: BaseViewController {

    var viewModel :MoviesListViewModel!
    @IBOutlet weak var tblMovies :UITableView!
    

    //MARK:- View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.viewModel.getMovies()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Memory Management Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - Setup Methods
extension MoviesListViewController {
    
    private func setup(){
        self.setupUI()
        self.setupBinding(with: self.viewModel)
    }
    
    private func setupUI() {
        self.configureNavigationWithAction(NSLocalizedString("AliveCore", comment: ""), leftImage: nil, actionForLeft: nil, rightImage: nil, actionForRight: nil)
        self.tblMovies.tableFooterView = UIView()
    }
    
    private func setupBinding(with viewModel: MoviesListViewModel){
        
        self.viewModel.movieTableData.asObservable()
            .bind(to: tblMovies.rx.items(cellIdentifier: String(describing: MovieTableViewCell.self), cellType: MovieTableViewCell.self)) { row, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
        
        tblMovies.rx
            .willDisplayCell
            .filter({[weak self] (cell, indexPath) in
                guard let `self` = self else { return false }
                return (indexPath.row + 1) == self.tblMovies.numberOfRows(inSection: indexPath.section) - 3
            })
            .throttle(1.0, scheduler: MainScheduler.instance)
            .map({ event -> Void in
                return Void()
            })
            .bind(to: viewModel.callNextPage)
            .disposed(by: disposeBag)
        
        self.tblMovies
            .rx
            .modelSelected(Movie.self)
            .bind(to: viewModel.selectedMovie)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }
                self.hideActivityIndicator()
                if isLoading {
                    self.showActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                self.showAlertDialogue(title: title, message: message)
            }).disposed(by: disposeBag)
    }
    
}

//MARK: - Movie Tableview Cell
class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imvMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var favoriteButtonView: UIView!
    
    let faveButton = FaveButton(
        frame: CGRect(x:0, y:0, width: 44, height: 44),
        faveIconNormal: UIImage(named: "star")
    )
    
    func configure(with movie: Movie){
        faveButton.delegate = self
        self.imvMovie.downloadImageWithCaching(with: movie.imageURL,placeholderImage: #imageLiteral(resourceName: "placeholder-image"))
        self.lblMovieTitle.text = movie.title ?? ""
        favoriteButtonView.addSubview(faveButton)
        
    }
    
}
