//
//  InstumentsCollectionViewCell.swift
//  Bethie
//
//  Created by Artyom Prima on 15.02.2023.
//

import UIKit

class InstrumentsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "InstumentsCollectionViewCell"
    
    var didSelectFigure: ((Figure) -> Void)?
    
    private let circleButton:  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(circleButtonTapp), for: .touchUpInside)
        return button
    }()
    
    private let rectangleButton:  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle"), for: .normal)
        button.addTarget(self, action: #selector(rectangleButtonTapp), for: .touchUpInside)
        button.tintColor = .green
        return button
    }()
    
    private let triangleButton:  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "triangle"), for: .normal)
        button.addTarget(self, action: #selector(triangleButtonTapp), for: .touchUpInside)
        button.tintColor = .green
        return button
    }()
    
    private let pencilButton:  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paintbrush.pointed"), for: .normal)
        button.addTarget(self, action: #selector(pencilButtonTapp), for: .touchUpInside)
        button.tintColor = .green
        return button
    }()
    
    private let lineButton:  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.addTarget(self, action: #selector(lineButtonTapp), for: .touchUpInside)
        button.tintColor = .green
        return button
    }()
    
    private let figureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 46
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(figureStackView)
        figureStackView.addArrangedSubview(circleButton)
        figureStackView.addArrangedSubview(rectangleButton)
        figureStackView.addArrangedSubview(triangleButton)
        figureStackView.addArrangedSubview(pencilButton)
        figureStackView.addArrangedSubview(lineButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            figureStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 46),
            figureStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -46),
            figureStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            figureStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func circleButtonTapp() {
        didSelectFigure?(.circle)
    }
    
    @objc func rectangleButtonTapp() {
        didSelectFigure?(.rectangle)
    }
    
    @objc func triangleButtonTapp() {
        didSelectFigure?(.triangle)
    }
    
    @objc func pencilButtonTapp() {
        didSelectFigure?(.pencil)
    }
    
    @objc func lineButtonTapp() {
        didSelectFigure?(.line)
    }
}


