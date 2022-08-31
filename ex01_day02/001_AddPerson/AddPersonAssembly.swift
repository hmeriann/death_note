//
//  AddPersonAssembly.swift
//  ex01_day02
//
//  Created by Zuleykha Pavlichenkova on 09.08.2022.
//

import Foundation
import UIKit

protocol IAddPersonDelegate: AnyObject {
    // AddPersonView will call this method to hand the typed data to the DeathNotesView
    func userDidTapDone(with person: Person)
}

protocol IAddPersonAssembly {
    func assemble(delegate: IAddPersonDelegate) -> UIViewController
}

final class AddPersonAssembly: IAddPersonAssembly {

    func assemble(delegate: IAddPersonDelegate) -> UIViewController {
        let presenter = AddPersonPresenter(delegate: delegate)
        let viewController = AddPersonViewController(presenter: presenter)
        presenter.view = viewController
        
// теперь не нужен, потому что пушу  этот вью из DeathNotesViewController при сетапе навбара
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [viewController]
        
        return viewController
    }
}
