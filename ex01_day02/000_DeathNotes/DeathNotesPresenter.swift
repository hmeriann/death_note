//
//  DeathNotesPresenter.swift
//  ex00_day02
//
//  Created by Zuleykha Pavlichenkova on 03.07.2022.
//

import Foundation

struct Person {
    let name: String
    let dateStr: String
    let description: String
}

protocol IDeathNotesPresenter {
    var persons: [Person] { get }
    
    func onViewDidLoad()
}

final class DeathNotesPresenter {
    
    weak var view: IDeathNotesView?
    
    lazy var persons: [Person] = [
        Person(name: "First", dateStr: dateFormatter.string(from: Date()), description: "😣 🔫"),
        Person(name: "Second", dateStr: dateFormatter.string(from: Date()), description: "🧟‍♀️ 🧟 🧟‍♂️ Had been eaten by zombies"),
        Person(name: "Third", dateStr: dateFormatter.string(from: Date()), description: "Another very long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long description")
    ]
        
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        return dateFormatter
    }()

}

// MARK: - IDeathNotesPresenter

extension DeathNotesPresenter: IDeathNotesPresenter {
   
    func onViewDidLoad() {
        // loading data
        view?.updateUI()
    }
}

// MARK: - IAddPersonDelegate

extension DeathNotesPresenter: IAddPersonDelegate {
    func userDidTapDone(with person: Person) {
//        print(#function, person)
        persons.append(person)
        view?.updateUI()
    }
    
    
}
