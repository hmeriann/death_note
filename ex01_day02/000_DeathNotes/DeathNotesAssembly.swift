//
//  DeathNotesAssembly.swift
//  ex00_day02
//
//  Created by Zuleykha Pavlichenkova on 03.07.2022.
//

import Foundation
import UIKit

protocol IDeathNotesAssembly {
    
    func assemble() -> UIViewController
}

final class DeathNotesAssembly: IDeathNotesAssembly {
   
    func assemble() -> UIViewController {
        let presenter = DeathNotesPresenter()
        let viewController = DeathNotesViewController(presenter: presenter)
        presenter.view = viewController
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        return navigationController
    }
}
