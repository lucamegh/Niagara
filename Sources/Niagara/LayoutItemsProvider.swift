/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

class LayoutItemProvider {
    
    private var columnHeights: [CGFloat]
    
    private let columnCount: CGFloat
    
    private let itemSizeProvider: UICollectionViewWaterfallLayoutItemSizeProvider
    
    private let spacing: CGFloat
    
    private let collectionWidth: CGFloat
    
    init(
        configuration: UICollectionLayoutWaterfallConfiguration,
        collectionWidth: CGFloat
    ) {
        self.columnHeights = [CGFloat](repeating: 0, count: configuration.columnCount)
        self.columnCount = CGFloat(configuration.columnCount)
        self.itemSizeProvider = configuration.itemSizeProvider
        self.spacing = configuration.spacing
        self.collectionWidth = collectionWidth
    }
    
    func item(for indexPath: IndexPath) -> NSCollectionLayoutGroupCustomItem {
        let frame = frame(for: indexPath)
        columnHeights[columnIndex()] = frame.maxY + spacing
        return NSCollectionLayoutGroupCustomItem(frame: frame)
    }
    
    func maxColumnHeight() -> CGFloat {
        return columnHeights.max() ?? 0
    }
    
    private func frame(for indexPath: IndexPath) -> CGRect {
        let size = itemSize(for: indexPath)
        let origin = itemOrigin(width: size.width)
        return CGRect(origin: origin, size: size)
    }
    
    private func itemOrigin(width: CGFloat) -> CGPoint {
        let y = columnHeights[columnIndex()].rounded()
        let x = (width + spacing) * CGFloat(columnIndex())
        return CGPoint(x: x, y: y)
    }
    
    private func itemSize(for indexPath: IndexPath) -> CGSize {
        let width = columnWidth()
        let height = itemHeight(for: indexPath, itemWidth: width)
        return CGSize(width: width, height: height)
    }
    
    private func columnWidth() -> CGFloat {
        let spacing = (columnCount - 1) * spacing
        return (collectionWidth - spacing) / columnCount
    }
    
    private func itemHeight(for indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        let itemSize = itemSizeProvider(indexPath)
        let aspectRatio = itemSize.height / itemSize.width
        let itemHeight = itemWidth * aspectRatio
        return itemHeight.rounded()
    }
    
    private func columnIndex() -> Int {
        columnHeights
            .enumerated()
            .min(by: { $0.element < $1.element })?
            .offset ?? 0
    }
}
