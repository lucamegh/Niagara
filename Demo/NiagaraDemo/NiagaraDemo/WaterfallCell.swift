/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

class WaterfallCell: UICollectionViewCell {
        
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "water_image")
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ViewModel) {
        indexLabel.text = viewModel.indexLabelText
        contentView.backgroundColor = viewModel.contentViewBackgroundColor
    }
    
    private func setUp() {
        contentView.addSubview(indexLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: indexLabel.topAnchor, constant: -8),
            {
                let constraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5)
                constraint.priority = .defaultHigh + 1
                return constraint
            }(),
            
            indexLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indexLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension WaterfallCell {
    
    struct ViewModel {
        
        let indexLabelText: String
        
        let contentViewBackgroundColor: UIColor
        
        init(item: WaterfallItem) {
            indexLabelText = "\(item.index + 1)"
            contentViewBackgroundColor = item.color
        }
    }
}
