//
//  UndoCollectionViewCell.swift
//  Bethie
//
//  Created by Artyom Prima on 17.02.2023.
//

import UIKit

class UndoCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "UndoCollectionViewCell"
    
    var  didReturnTapped: (() -> Void)?
    var  didClearTapped: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.turn.up.left"), for: .normal)
        button.tintColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let clearButton:  UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClearTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped(_ sender: UIButton) {
        didReturnTapped?()
    }
    
    @objc func buttonClearTapped(_ sender: UIButton) {
        didClearTapped?()
    }
    
    private func setConstraints() {
        contentView.addSubview(button)
        contentView.addSubview(clearButton)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            clearButton.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 46),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

