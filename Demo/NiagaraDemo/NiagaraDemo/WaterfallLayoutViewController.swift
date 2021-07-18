/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Combine
import Niagara
import ReusableView
import UIKit

final class WaterfallLayoutViewController: UICollectionViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private let editLayoutButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "ellipsis.circle")
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = WaterfallLayoutViewModel()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Niagara"
        collectionView.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = editLayoutButtonItem
        
        viewModel.waterfallLayoutConfiguration.sink { [unowned self] configuration in
            let layout = UICollectionViewCompositionalLayout.waterfall(configuration: configuration)
            collectionView.setCollectionViewLayout(layout, animated: true)
        }.store(in: &cancellables)
        
        viewModel.snapshot.sink { [unowned self] snapshot in
            dataSource.apply(snapshot)
        }.store(in: &cancellables)
        
        viewModel.menu.sink { [unowned self] menu in
            editLayoutButtonItem.menu = menu
        }.store(in: &cancellables)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.removeItem(at: indexPath)
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, WaterfallItem> {
        let registration = makeCellRegistration()
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: item
            )
        }
    }
    
    private func makeCellRegistration() -> UICollectionView.CellRegistration<WaterfallCell, WaterfallItem> {
        UICollectionView.CellRegistration { [viewModel] cell, indexPath, item in
            let viewModel = viewModel.makeViewModel(for: item)
            cell.configure(with: viewModel)
        }
    }
}
