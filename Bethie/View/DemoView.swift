//
//  DemoView.swift
//  Bethie
//
//  Created by Artyom Prima on 12.02.2023.
//

import UIKit

class DemoView: UIView {
    
    var demoViews: [DemoView] = []
    private let caretaker = DemoViewCaretaker()
    private var path: UIBezierPath!
    private var figure: Figure?
    private var firstPoint: CGPoint?
    private var secondPoint: CGPoint?
    private var fill = false
    private var chooseColor = UIColor.green
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func saveState() {
        if let figure = figure {
            let memento = DemoViewMemento(path: path,
                                          fill: fill,
                                          color: chooseColor,
                                          figure: figure)
            caretaker.addMemento(memento)
        }
    }
    
    private func setMemento(_ memento: DemoViewMemento) {
        self.path = memento.path
        self.figure = memento.figure
        self.fill = memento.fill
        self.chooseColor = memento.color
        self.draw()
    }
    
    func restoreState() {
        let mementos = caretaker.getMementos()
        for memento in mementos {
            if let memento = memento {
                setMemento(memento)
            }
        }
    }
    
    func createRectangle() {
        if let firstPoint = firstPoint, let secondPoint = secondPoint {
            let path = UIBezierPath(rect: CGRect(x: min(firstPoint.x, secondPoint.x),
                                                 y: min(firstPoint.y, secondPoint.y),
                                                 width: abs(firstPoint.x - secondPoint.x),
                                                 height: abs(firstPoint.y - secondPoint.y)))
            self.path = path
        }
    }
    
    func createTriangle() {
        if let firstPoint = firstPoint, let secondPoint = secondPoint {
            let path = UIBezierPath()
            path.move(to: firstPoint)
            path.addLine(to: CGPoint(
                x: secondPoint.x,
                y: firstPoint.y))
            path.addLine(to: secondPoint)
            path.close()
            self.path = path
        }
    }
    
    func createCircle() {
        if let firstPoint = firstPoint, let secondPoint = secondPoint {
            let radius = sqrt(pow(secondPoint.x - firstPoint.x, 2) + pow(secondPoint.y - firstPoint.y, 2))
            let path = UIBezierPath(arcCenter: firstPoint, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
            self.path = path
        }
    }
    
    func createLine() {
        if let firstPoint = firstPoint, let secondPoint = secondPoint {
            let path = UIBezierPath()
            path.move(to: firstPoint)
            path.addLine(to: secondPoint)
            self.path = path
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        guard let point = point else { return }
        firstPoint = point
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, var firstPoint = firstPoint {
            let point = touch.location(in: self)
            switch figure {
            case .line:
                createPencil(from: firstPoint, to: point)
                firstPoint = point
                draw()
            default:
                print("Something Wrong")
            }
        }
    }
    
    func createPencil(from startPoint: CGPoint, to endPoint: CGPoint){
        path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
    }
    
    func draw(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2
        if fill == false {
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = chooseColor.cgColor
        } else {
            shapeLayer.fillColor = chooseColor.cgColor
            shapeLayer.strokeColor = chooseColor.cgColor
        }
        self.layer.addSublayer(shapeLayer)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            secondPoint = touch.location(in: self)
            switch figure {
            case .circle:
                self.createCircle()
                draw()
            case .triangle:
                self.createTriangle()
                draw()
            case .rectangle:
                self.createRectangle()
                draw()
            case .pencil:
                self.createLine()
                draw()
            default:
                print("Something Wrong")
            }
            saveState()
        }
    }
    
    @objc func undoButtonTapped() {
        if let lastDemoView = demoViews.last {
            lastDemoView.removeFromSuperview()
            demoViews.removeLast()
        }
    }
    
    func selectFigure(_ selected: Figure) {
        figure = selected
    }
    
    func fill(_ isOn: Bool) {
        fill = isOn
    }
    
    func selectColor(_ selected: UIColor) {
        chooseColor = selected
    }
    
    func undo() {
        if let lastLayer = self.layer.sublayers?.last {
            lastLayer.removeFromSuperlayer()
        }
        let mementos = caretaker.getMementos()
        for memento in mementos {
            if let memento = memento {
                setMemento(memento)
            }
            caretaker.removeAllMementos()
        }
        
    }
    
    func clear() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        demoViews.removeAll()
        // path.removeAll()
        setNeedsDisplay()
    }
}





