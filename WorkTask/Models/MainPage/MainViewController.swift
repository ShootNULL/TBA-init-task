//
//  MainViewController.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 18.12.2023.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    private let presenter = MainViewPresenter()
    
    private let scrollView = UIScrollView()
    
    private var fullScreenSwitcher = false
    
    override func viewDidLoad() {
        setUp()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        
        setUpScrollView()
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
    
    private func addViews() {
        
        let info = presenter.getPhotos()
        
        for i in 0...10 {
            let photo = PhotoView(photo: info[0][0], creationDate: info[1][0], name: info[2][0], tags: info[3])
            
            photo.translatesAutoresizingMaskIntoConstraints = false
            
            let photoConstraints = [
                photo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                photo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                photo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat(20 + (i * 220))),
                photo.heightAnchor.constraint(equalToConstant: 200)
            ]
            
            self.scrollView.addSubview(photo)
            NSLayoutConstraint.activate(photoConstraints)
        
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
            photo.addGestureRecognizer(tap)
            
            if i * 220 + 20 > Int(self.view.frame.height) {
                scrollView.contentSize = CGSize(width: Int(self.view.frame.width), height: i * 220 + 20)
            }
        }
        
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
