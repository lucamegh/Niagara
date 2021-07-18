/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Combine
import Niagara
import UIKit
import UIKitHelpers

class WaterfallLayoutViewModel {
    
    lazy var snapshot = itemsSubject.map { items -> NSDiffableDataSourceSnapshot<Int, WaterfallItem> in
        var snapshot = NSDiffableDataSourceSnapshot<Int, WaterfallItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        return snapshot
    }.eraseToAnyPublisher()
        
    lazy var waterfallLayoutConfiguration = Publishers.CombineLatest3(
        columnCountSubject,
        spacingSubject,
        contentInsetsReferenceSubject
    ).map { [unowned self] _, _, _ in
        makeWaterfallLayoutConfiguration()
    }.eraseToAnyPublisher()
    
    lazy var menu = Publishers.CombineLatest3(
        columnCountSubject,
        spacingSubject,
        contentInsetsReferenceSubject
    ).map { [unowned self] _, _, _ in
        makeMenu()
    }.eraseToAnyPublisher()
    
    private let columnCountSubject = CurrentValueSubject<Int, Never>(
        defaultColumnCount
    )
    
    private let spacingSubject = CurrentValueSubject<CGFloat, Never>(
        defaultSpacing
    )
    
    private let contentInsetsReferenceSubject = CurrentValueSubject<UIContentInsetsReference, Never>(
        defaultContentInsetsReference
    )
    
    private let itemsSubject = CurrentValueSubject<[WaterfallItem], Never>(
        defaultItems
    )
        
    init() {}
    
    func makeViewModel(for item: WaterfallItem) -> WaterfallCell.ViewModel {
        WaterfallCell.ViewModel(item: item)
    }
    
    func removeItem(at indexPath: IndexPath) {
        itemsSubject.value.remove(at: indexPath.row)
    }
    
    private func reset() {
        columnCountSubject.value = Self.defaultColumnCount
        spacingSubject.value = Self.defaultSpacing
        contentInsetsReferenceSubject.value = Self.defaultContentInsetsReference
        itemsSubject.value = Self.defaultItems
    }
    
    private func makeWaterfallLayoutConfiguration() -> UICollectionLayoutWaterfallConfiguration {
        UICollectionLayoutWaterfallConfiguration(
            columnCount: columnCountSubject.value,
            spacing: spacingSubject.value,
            contentInsetsReference: contentInsetsReferenceSubject.value,
            itemSizeProvider: { [itemsSubject] indexPath in
                itemsSubject.value[indexPath.row].size
            }
        )
    }
    
    private func makeMenu() -> UIMenu {
        UIMenu(
            title: "Edit Layout",
            children: [
                UIMenu(
                    options: .displayInline,
                    children: [
                        makeColumnCountSelectionMenu(),
                        makeSpacingSelectionMenu(),
                        makeContentInsetsReferenceMenu()
                    ]
                ),
                UIMenu(
                    options: .displayInline,
                    children: [
                        makeResetAction()
                    ]
                )
            ]
        )
    }
    
    private func makeColumnCountSelectionMenu() -> UIMenu {
        UIMenu.picker(
            title: "Column Count",
            symbolName: "building.columns",
            items: [1, 2, 3, 4, 5, 6, 7, 8],
            itemTitle: String.init,
            itemSubject: columnCountSubject
        )
    }
    
    private func makeSpacingSelectionMenu() -> UIMenu {
        UIMenu.picker(
            title: "Spacing",
            symbolName: "arrow.left.and.right",
            items: [0, 2, 8, 16],
            itemTitle: { String(format: "%.0f pt", $0) },
            itemSubject: spacingSubject
        )
    }
    
    private func makeContentInsetsReferenceMenu() -> UIMenu {
        UIMenu.picker(
            title: "Content Insets Reference",
            symbolName: "squareshape.dashed.squareshape",
            items: [.automatic, .none, .safeArea, .layoutMargins, .readableContent],
            itemTitle: { reference in
                switch reference {
                case .automatic:
                    return "Automatic"
                case .none:
                    return "None"
                case .safeArea:
                    return "Safe Area"
                case .layoutMargins:
                    return "Layout Margins"
                case .readableContent:
                    return "Readable Content"
                @unknown default:
                    fatalError()
                }
            },
            itemSubject: contentInsetsReferenceSubject
        )
    }
    
    private func makeResetAction() -> UIAction {
        UIAction(
            title: "Reset",
            image: UIImage(systemName: "arrow.counterclockwise"),
            handler: { [unowned self] _ in
                reset()
            }
        )
    }
}

private extension WaterfallLayoutViewModel {

    static let defaultColumnCount = 2
    
    static let defaultSpacing = CGFloat(8)
    
    static let defaultContentInsetsReference = UIContentInsetsReference.automatic
    
    static let defaultItems = (0..<1000).map(WaterfallItem.init)
}
