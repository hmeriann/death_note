//
//  AddPersonViewController.swift
//  ex01_day02
//
//  Created by Zuleykha Pavlichenkova on 09.08.2022.
//

import Foundation
import UIKit

private extension CGFloat {
    static let standardMargin: CGFloat = 16.0
}

protocol IAddPersonViewController: AnyObject {
    
}

final class AddPersonViewController: UIViewController {
    
    // MARK: Dependencies
    private let presenter: IAddPersonPresenter
    
    // MARK: UI
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "paper")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = .standardMargin
        return stackView
    }()
    
    private lazy var nameTextField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "Name"
        name.keyboardType = .default
        name.textAlignment = .center
        return name
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private lazy var descTexField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Which of death would you choose for the person?"
        textField.textAlignment = .natural
        textField.contentVerticalAlignment = .top
        textField.borderStyle = .line
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    // MARK: init
    
    init(
        presenter: IAddPersonPresenter
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
}

extension AddPersonViewController: IAddPersonViewController {

}

// MARK: - Private

private extension AddPersonViewController {
    
    func setUpNavBar() {
        navigationItem.title = "Add a Person"
        
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonDidTap))
        navigationItem.rightBarButtonItem = button
    }
    
    // MARK: Set Up UI
    func setUpUI() {
        setUpNavBar()
        
        view.addSubview(backgroundImage)
        view.addSubview(rootStackView)
        view.backgroundColor = .black
        view.clipsToBounds = true
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: rootStackView.topAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .standardMargin),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.standardMargin),
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        rootStackView.addArrangedSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: rootStackView.topAnchor, constant: 8)
        ])
        rootStackView.addArrangedSubview(datePicker)
        rootStackView.addArrangedSubview(descTexField)
        NSLayoutConstraint.activate([
            descTexField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 8),
            descTexField.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: 16),
            descTexField.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor, constant: 16),
            descTexField.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func onDoneButtonDidTap() {
        guard let name = nameTextField.text, name != "",
              datePicker.date > Date()
        else {
            showError()
            return
        }

        presenter.savePerson(
            with: name,
            date: datePicker.date,
            description: descTexField.text ?? ""
        )
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Error
    func showError() {
        let alert = UIAlertController(title: "Error", message: "🤷🏼‍♀️ If the name field is empty, no one should be added.\n\n🗓 You should not be able to choose a past date.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


