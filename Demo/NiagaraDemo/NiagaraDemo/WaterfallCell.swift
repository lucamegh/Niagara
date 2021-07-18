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
        return label
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
        NSLayoutConstraint.activate([
            indexLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indexLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
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
