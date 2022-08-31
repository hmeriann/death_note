//
//  ViewController.swift
//  ex00_day02
//
//  Created by Zuleykha Pavlichenkova on 03.07.2022.
//

import UIKit

protocol IDeathNotesView: AnyObject {
    func updateUI()
}

final class DeathNotesViewController: UIViewController {

    // MARK: Dependencies
    private let presenter: IDeathNotesPresenter & IAddPersonDelegate
    
    // MARK: UI
    
    private lazy var tableView: UITableView = {
        // Instance of the UITableView object which will be added as sub view in setUpUI()
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        
        // register cell to be able to reuse it with new cell's contents
        tableView.register(
            DeathNoteTableViewCell.self,
            forCellReuseIdentifier: "DeathNoteTableViewCell"
        )
        
        return tableView
    } ()
    
    // MARK: Init
    init(
        presenter: IDeathNotesPresenter & IAddPersonDelegate
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
        presenter.onViewDidLoad()
        view.backgroundColor = .black
        tableView.backgroundColor = .black
    }
}

// MARK: - IDeathNotesView

extension DeathNotesViewController: IDeathNotesView {
    func updateUI() {
        print(#function)
        tableView.reloadData()
    }
}

// MARK: Set Up UI of the View Controller

private extension DeathNotesViewController {
    
    func setUpUI() {
        
        setUpNavBar()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setUpNavBar() {
        navigationItem.title = "Death Note"
        
        let buttonAddPerson = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddPersonButtonDidTap))
        navigationItem.rightBarButtonItem = buttonAddPerson
    }
    
    @objc func onAddPersonButtonDidTap() {
        let addPersonViewController = AddPersonAssembly().assemble(delegate: presenter)
        // показывала новый вью поверх текущего
//        present(addPersonViewController, animated: true, completion: nil)
        
        // Пушу в навигейшен контроллер вью добавления перса поверх главного, чтобы была кнопка возврата на предыдущий вью
        self.navigationController?.pushViewController(addPersonViewController, animated: true)
    }
}

extension DeathNotesViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        // Customize the cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeathNoteTableViewCell") as? DeathNoteTableViewCell else { return UITableViewCell() }
        cell.configure(with: presenter.persons[indexPath.item])
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.persons.count
    }
}
