/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

public extension UICollectionViewCompositionalLayout {
    
    static func waterfallSection(
        columnCount: Int = 2,
        spacing: CGFloat = 8,
        contentInsetsReference: UIContentInsetsReference = .automatic,
        numberOfItems: @escaping () -> Int,
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int,
        itemSizeProvider: @escaping UICollectionViewWaterfallLayoutItemSizeProvider
    ) -> NSCollectionLayoutSection {
        let configuration = UICollectionLayoutWaterfallConfiguration(
            columnCount: columnCount,
            spacing: spacing,
            contentInsetsReference: contentInsetsReference,
            numberOfItems: numberOfItems,
            itemSizeProvider: itemSizeProvider
        )
        
        return waterfallSection(
            configuration: configuration,
            environment: environment,
            sectionIndex: sectionIndex
        )
    }
    
    static func waterfallSection(
        configuration: UICollectionLayoutWaterfallConfiguration,
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        var items = [NSCollectionLayoutGroupCustomItem]()
        let itemProvider = LayoutItemProvider(
            configuration: configuration,
            collectionWidth: environment.container.contentSize.width
        )
        
        for i in 0..<configuration.numberOfItems() {
            let indexPath = IndexPath(item: i, section: sectionIndex)
            let item = itemProvider.item(for: indexPath)
            items.append(item)
        }
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(itemProvider.maxColumnHeight())
        )
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupLayoutSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsetsReference = configuration.contentInsetsReference
        return section
    }
}
