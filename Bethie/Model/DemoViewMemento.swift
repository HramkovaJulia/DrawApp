//
//  DemoViewMemento.swift
//  Bethie
//
//  Created by Artyom Prima on 01.03.2023.
//

import Foundation
import UIKit

class DemoViewMemento {
    let path: UIBezierPath
    let fill: Bool
    let color: UIColor
    let figure: Figure
    
    init(path: UIBezierPath, fill: Bool, color: UIColor, figure: Figure) {
        self.path = path
        self.fill = fill
        self.color = color
        self.figure = figure
    }
}
