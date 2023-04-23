//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import UIKit

class HomeViewController: UIViewController, LocationViewModelOutput, CharacterViewModelOutput {
    
    enum Section: Int, CaseIterable {
        case locations
        case characters
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var locationsArray = [Locations]()
    var selectedCell = Int()
    var selectedIndex = Int()
    var charactersArray = [CharactersModel]()
    lazy var homeVM = HomeViewModel()
    let network = Service()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeVM.getLocations()
        configureCollectionView()
        configureNativationController()
        self.homeVM.locationOutput = self
        self.homeVM.charaterOutput = self
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func configureNativationController() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
           let image = UIImage(named: "logo")
           imageView.image = image
           navigationItem.titleView = imageView
    }
  
    func locations(locations: [Locations]) {
        DispatchQueue.main.async {
            self.locationsArray = locations
            self.collectionView.reloadData()
        }
    }
    func characters(characters: charactersModel) {
        DispatchQueue.main.async {
            self.charactersArray = characters
            self.collectionView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "DetailViewController" {
                   let characterDetails = sender as? CharactersModel
                   let destinationVC = segue.destination as? DetailViewController
                   destinationVC!.characterDetails = characterDetails
               }
           }
    
    func configureCollectionView() {
        
        collectionView.register(UINib(nibName: "LocationsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LocationsCollectionViewCell")
        collectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharactersCollectionViewCell")
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            guard let sectionKind = Section(rawValue: sectionIndex) else { fatalError("no section at index ")}
            switch sectionKind {
            case .locations:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
                //item.contentInsets.bottom = 20
                item.contentInsets.trailing = 5
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(150)), subitems: [item])
               group.contentInsets.top = 30
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.9
                    let maxScale: CGFloat = 1.03
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                            }
                        }
                    return section
            case .characters:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 20
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                group.contentInsets.leading = 20
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.orthogonalScrollingBehavior = .none
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midY - offset.y) - environment.container.contentSize.height / 2.0)
                    let minScale: CGFloat = 0.87
                    let maxScale: CGFloat = 1.1
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.height), minScale)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                                        }
                }
                return section
            }
        }
        return layout
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {fatalError("")}
        switch section {
        case .locations:
            return locationsArray.count
        case .characters:
            return charactersArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = Section(rawValue: indexPath.section) else {fatalError("")}
        switch sectionKind {
        case .locations:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationsCollectionViewCell", for: indexPath) as? LocationsCollectionViewCell {
                let locationModel = locationsArray[indexPath.row]
                cell.viewCell(model: locationModel)
                if selectedCell == indexPath.row {
                    cell.configure(select: true)
                }
                else {
                    cell.configure(select: false)
                }
                return cell
            } else {
                return UICollectionViewCell()
            }
        case .characters:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCollectionViewCell", for: indexPath) as? CharactersCollectionViewCell {
                let characterModel = charactersArray[indexPath.row]
                cell.viewCell(model: characterModel)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionKind = Section(rawValue: indexPath.section) else {fatalError("")}
        switch sectionKind {
        case .locations:
            selectedCell = indexPath.row
            selectedIndex = locationsArray[indexPath.row].id
            homeVM.getSingleLocationAndCharacters(with: selectedIndex)
        case .characters:
            let characterModel = charactersArray[indexPath.row]
            performSegue(withIdentifier: "DetailViewController", sender: characterModel)
        }
    }
}
