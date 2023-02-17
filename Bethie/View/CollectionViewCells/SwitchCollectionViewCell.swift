//
//  SwitchCollectionViewCell.swift
//  Bethie
//
//  Created by Artyom Prima on 16.02.2023.
//

import Foundation
import UIKit

class SwitchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SwitchlCollectionViewCell"
    
     var fillButtonTapped: ((Bool) -> ())?
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .green
        return toggle
    }()
    
    private let fillLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill"
        label.textColor = .green
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let titleToggleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        toggleSwitch.addTarget(self, action: #selector(toggleValueChanged), for: .valueChanged)
    }
    
    @objc func toggleValueChanged(_ sender: UISwitch) {
        fillButtonTapped?(sender.isOn)
        print(sender.isOn)
    }
    
    private func setupViews() {
        addSubview(titleToggleStackView)
        titleToggleStackView.addArrangedSubview(fillLabel)
        titleToggleStackView.addArrangedSubview(toggleSwitch)
        
        titleToggleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleToggleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            titleToggleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            titleToggleStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleToggleStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



