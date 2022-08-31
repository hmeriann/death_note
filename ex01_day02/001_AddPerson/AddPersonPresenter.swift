//
//  AddPersonPresenter.swift
//  ex01_day02
//
//  Created by Zuleykha Pavlichenkova on 09.08.2022.
//

import Foundation

protocol IAddPersonPresenter {
    func savePerson(with name: String, date: Date, description: String)
}

final class AddPersonPresenter {
    
    weak var view: IAddPersonViewController?
    private weak var delegate: IAddPersonDelegate?
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        return dateFormatter
    }()
    
    init(delegate: IAddPersonDelegate) {
        self.delegate = delegate
    }
}

// MARK: - IAddPersonPresenter

extension AddPersonPresenter: IAddPersonPresenter {
    func savePerson(with name: String, date: Date, description: String) {
        let dateString = dateFormatter.string(from: date)
        let person = Person(name: name, dateStr: dateString, description: description)
        delegate?.userDidTapDone(with: person)
    }
    
}
