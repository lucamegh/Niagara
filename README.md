# Niagara 🚿

Waterfall collection view compositional layout.

<p>
  	<img src="https://user-images.githubusercontent.com/7815995/126075440-08b694da-0758-4b69-a5ac-f88243a0591f.gif" alt="Niagara" title="Niagara"> 
</p>

## Installation

Niagara is distributed using [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your Package.swift manifest:
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/lucamegh/Niagara", from: "1.0.0")
    ],
    ...
)
```

## Usage

```swift
import Niagara

collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.waterfall { indexPath in
    // resolve item size
}
```

Please check out the [demo](https://github.com/lucamegh/Niagara/tree/main/Demo/NiagaraDemo) to see how to further customize your waterfall layouts.
