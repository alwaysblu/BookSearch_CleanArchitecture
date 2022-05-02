//
//  BookListCell.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit

final class BookListCell: UITableViewCell {
    static let identifier = "BookListCell"
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 8)
        label.numberOfLines = 0
        
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 0
        
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, descriptionLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.axis = .vertical
        
        return stackView
    }()
    private var loadTask: Cancellable? {
        willSet{ loadTask?.cancel() }
    }
    
    private var viewModel: BooksSearchItemViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            dateLabel.text = viewModel.publishedDate
            descriptionLabel.text = viewModel.authors?.joined()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addAllSubviews()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookListCell {
    func configure(viewModel: BooksSearchItemViewModel, imageRepository: ImageRepository?) {
        self.viewModel = viewModel
        loadTask = imageRepository?.downloadImage(url: viewModel.thumbnail) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            case .failure(let error):
                "\(error)".log()
            }
        }
    }
    
}

extension BookListCell {
    private func addAllSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(stackView)
    }
}
