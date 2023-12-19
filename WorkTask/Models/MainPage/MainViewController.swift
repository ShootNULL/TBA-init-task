//
//  MainViewController.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 18.12.2023.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    
    private let presenter = MainViewPresenter()
    
    private let scrollView = UIScrollView()
    private let searchBar = UISearchBar()
    
    private var currentViews = [UIView]()
    
    override func viewDidLoad() {

        setUp()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        
        setUpScrollView()
        addSearch()
        
        addViews()
        
    }
    
    private func setUpScrollView() {
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate(scrollViewConstraints)
        
    }
    
    func addSearch() {
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let searchBarConstraints = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
//            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate(searchBarConstraints)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchText == "" { searchBar.endEditing(true) }
        else if searchText == "name" { sortByNames() }
        else if searchText == "date" { sortByTime() }
        else if searchText.contains("aaa") { 
            let start = searchText.index(searchText.startIndex, offsetBy: 0)
            let end = searchText.index(searchText.endIndex, offsetBy: -3)
            let range = start..<end

            let mySubstring = searchText[range]
            findByTag(tag: String(mySubstring))
        }
        
        print(searchText)
        
    }
    
    private func addViews() {
        
        let info = API.shared
        
        var cardCounter = 0
        
        for i in info.results {
            let photo = PhotoView(photo: i.urls.small, creationDate: i.created_at!, name: i.user.name, tags: info.getTags(number: cardCounter))
            
            photo.translatesAutoresizingMaskIntoConstraints = false
            
            let photoConstraints = [
                photo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                photo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                photo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat(40 + (cardCounter * 220))),
                photo.heightAnchor.constraint(equalToConstant: 200)
            ]
            
            self.scrollView.addSubview(photo)
            NSLayoutConstraint.activate(photoConstraints)
        
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
            photo.addGestureRecognizer(tap)
            
            if cardCounter * 220 + 20 > Int(self.view.frame.height) {
                scrollView.contentSize = CGSize(width: Int(self.view.frame.width), height: cardCounter * 240 + 20)
            }
            
            cardCounter += 1
            
            currentViews.append(photo)
        }
        
    }
    
    private func sortByNames() {
        for i in currentViews {
            i.isHidden = true
        }
        currentViews = []
        
        API.shared.results.sort { $0.user.name < $1.user.name }
        
        addViews()
    }
    
    private func sortByTime() {
        for i in currentViews {
            i.isHidden = true
        }
        currentViews = []
        
        let dateFormatter = ISO8601DateFormatter()
        
        API.shared.results.sort { dateFormatter.date(from:($0.created_at!))! < dateFormatter.date(from:($1.created_at!))! }
        
        addViews()
    }
    
    private func findByTag(tag: String) {
        API.shared.searchTag(tag: tag)
        
        for i in currentViews {
            i.isHidden = true
        }
        currentViews = []
        
        addViews()
    }
    
    @objc func handleGesture(gesture: UITapGestureRecognizer) -> Void {
        let photo = gesture.view?.subviews[0] as! UIImageView
        goFullScreen(picture: photo)

    }
    
    private func goFullScreen(picture: UIImageView) {
        let imageView = picture
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}
