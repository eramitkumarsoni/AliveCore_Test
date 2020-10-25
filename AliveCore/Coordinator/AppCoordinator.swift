//
//  AppCoordinator.swift
//  AliveCore
//
//  Created by Amit soni on 25/10/20.
//

import UIKit
import RxSwift
import CoreData

final class AppCoordinator: Coordinator<Void> {
    
    private let navigationController:UINavigationController
    private let window: UIWindow
    let dependencies: AppDependency
    
    init(window:UIWindow, navigationController:UINavigationController, managedContext: NSManagedObjectContext) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = AppDependency(window: self.window, managedContext: managedContext)
    }
    
    override func start() -> Observable<Void> {
        // Show Movie list screen
        return showMovieList()
    }
    
    private func showMovieList() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(navigationController: navigationController, dependencies: self.dependencies)
        return coordinate(to: rootCoordinator)
    }
    
    deinit {
        plog(AppCoordinator.self)
    }
    
}

class RootCoordinator: Coordinator<Void>{
    typealias Dependencies = HasWindow & HasAPI & HasCoreData
    
    private let rootNavigationController:UINavigationController
    private let dependencies: Dependencies
    
    init(navigationController:UINavigationController, dependencies: Dependencies) {
        self.rootNavigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewModel = MoviesListViewModel.init(dependencies: self.dependencies)
        let viewController = UIStoryboard.main.moviesListViewController
        viewController.viewModel = viewModel
        
        rootNavigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
    deinit {
        plog(RootCoordinator.self)
    }
}
