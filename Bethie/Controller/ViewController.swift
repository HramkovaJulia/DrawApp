//
//  ViewController.swift
//  Bethie
//
//  Created by Artyom Prima on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let demoView = DemoView()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(demoView)
        demoView.frame = view.bounds
        view.backgroundColor = .white
        setConstraints()
        collectionView.register(InstrumentsCollectionViewCell.self, forCellWithReuseIdentifier: InstrumentsCollectionViewCell.identifier)
        collectionView.register(SwitchCollectionViewCell.self, forCellWithReuseIdentifier: SwitchCollectionViewCell.identifier)
        collectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerCollectionViewCell.identifier)
        collectionView.register(UndoCollectionViewCell.self, forCellWithReuseIdentifier: UndoCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstrumentsCollectionViewCell.identifier, for: indexPath) as! InstrumentsCollectionViewCell
            cell.didSelectFigure = { figure in
                self.demoView.selectFigure(figure)
            }
          return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwitchCollectionViewCell.identifier, for: indexPath) as! SwitchCollectionViewCell
            cell.fillButtonTapped = { isOn in
                self.demoView.fill(isOn)
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickerCollectionViewCell.identifier, for: indexPath) as! ColorPickerCollectionViewCell
            cell.didButtonTapped = { colorPickerVC in
                self.present(colorPickerVC, animated: true)
            }
            cell.didChooseButtonColor = { color in
                self.demoView.selectColor(color)
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UndoCollectionViewCell.identifier, for: indexPath) as! UndoCollectionViewCell
            cell.didReturnTapped = {
                self.demoView.undo()
            }
            cell.didClearTapped = {
                self.demoView.clear()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

