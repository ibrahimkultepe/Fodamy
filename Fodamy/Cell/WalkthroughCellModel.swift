//
//  WalkthroughCellModel.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 6.04.2023.
//

import UIKit

public protocol WalkthroughCellModelDataSource: AnyObject {
    var image: UIImage { get }
    var title: String { get }
    var description: String { get }
}

public protocol WalkthroughCellModelEventSource: AnyObject {
    
}

public protocol WalkthroughCellModelProtocol: WalkthroughCellModelDataSource, WalkthroughCellModelEventSource {
    
}

public final class WalkThroughCellModel: WalkthroughCellModelProtocol {
    
    public var image: UIImage
    public var title: String
    public var description: String
    
    public init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
}
