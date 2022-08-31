//
//  DeathNoteTableViewCell.swift
//  ex00_day02
//
//  Created by Zuleykha Pavlichenkova on 03.07.2022.
//
// useful link for configuring_the_cells_for_your_table: https://developer.apple.com/documentation/uikit/views_and_controls/table_views/configuring_the_cells_for_your_table
//
//
//

import UIKit

final class DeathNoteTableViewCell: UITableViewCell {
    
    // MARK: UI
    private lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "paper")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    // стек вью, куда набирается контент cell
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    // стек вью для первой строки cell: тут будут лейбл с именем и лейбл с датой
    private lazy var horizontalInnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.alignment = .firstBaseline
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }()
    
        // MARK: UI elements
    private lazy var labelName: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var labelDate: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1 
        
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - init
    override init(style:UITableViewCell.CellStyle,
         reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelName.text = ""
        labelDate.text = ""
        labelDescription.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        print(#function)
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: Person) {
        labelName.text = item.name
        labelDate.text = item.dateStr
        labelDescription.text = item.description
    }
    
    // MARK: - Set Up UI of the Cell
    
    func setUpUI() {
        addSubview(backgroundImage)
        addSubview(rootStackView)
        backgroundColor = .black
        clipsToBounds = true
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: rootStackView.topAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor, constant: 0),
            //отвязали от дна, чтобы не по высоте картинки было, а по высоте контента
//            backgroundImage.bottomAnchor.constraint(equalTo: rootStackView.bottomAnchor, constant: 0)
//            backgroundImage.heightAnchor.constraint(equalTo: rootStackView.heightAnchor, constant: 0)
        ])
        
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        rootStackView.addArrangedSubview(horizontalInnerStackView)
        NSLayoutConstraint.activate([
            horizontalInnerStackView.topAnchor.constraint(equalTo: rootStackView.topAnchor, constant: 8)
        ])
        horizontalInnerStackView.addArrangedSubview(labelName)
        horizontalInnerStackView.addArrangedSubview(labelDate)
        rootStackView.addArrangedSubview(labelDescription)
    }
}
