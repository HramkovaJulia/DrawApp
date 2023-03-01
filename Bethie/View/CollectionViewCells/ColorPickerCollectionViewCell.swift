//
//  ColorPickerCollectionViewCell.swift
//  Bethie
//
//  Created by Artyom Prima on 17.02.2023.
//

import UIKit

class ColorPickerCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "ColorPickerCollectionViewCell"
    
     var didChooseButtonColor: ((UIColor) -> Void)?
     var didButtonTapped: ((UIColorPickerViewController) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        colorPickerVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private lazy var buttonColor: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .green
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonColorChoose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let colorPickerVC = UIColorPickerViewController()
    
    @objc func buttonColorChoose() {
        
        colorPickerVC.supportsAlpha = false
        didButtonTapped?(colorPickerVC)
    }
    
    func addSubviews() {
        contentView.addSubview(buttonColor)
        NSLayoutConstraint.activate([
            buttonColor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            buttonColor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            buttonColor.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            buttonColor.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ColorPickerCollectionViewCell: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        buttonColor.backgroundColor = color
        didChooseButtonColor?(color)
    }
}
