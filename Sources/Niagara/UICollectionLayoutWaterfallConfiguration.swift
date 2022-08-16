/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

public struct UICollectionLayoutWaterfallConfiguration {
    
    public var columnCount: Int
    
    public var spacing: CGFloat
    
    public var contentInsetsReference: UIContentInsetsReference
    
    public var itemSizeProvider: UICollectionViewWaterfallLayoutItemSizeProvider
    
    public let numberOfItems: () -> Int
        
    public init(
        columnCount: Int = 2,
        spacing: CGFloat = 8,
        contentInsetsReference: UIContentInsetsReference = .automatic,
        numberOfItems: @escaping () -> Int,
        itemSizeProvider: @escaping UICollectionViewWaterfallLayoutItemSizeProvider
    ) {
        self.columnCount = columnCount
        self.spacing = spacing
        self.contentInsetsReference = contentInsetsReference
        self.itemSizeProvider = itemSizeProvider
        self.numberOfItems = numberOfItems
    }
}
