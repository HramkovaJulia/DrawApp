//
//  DemoViewCaretaker.swift
//  Bethie
//
//  Created by Artyom Prima on 01.03.2023.
//

import Foundation

class DemoViewCaretaker {
    
    private var mementos: [DemoViewMemento] = []
    
    func addMemento(_ memento: DemoViewMemento) {
        mementos.append(memento)
    }
    
    func getMementos() -> [DemoViewMemento?] {
        return mementos
    }
    
    func removeAllMementos() {
        mementos.removeAll()
    }
  }
