//
//  CustomViews.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 18.12.2023.
//

import Foundation
import UIKit

class PhotoView: UIView {
    
    var photo: String
    var creationDate: String
    var name: String
    var tags: [String]
    
    init(photo: String, creationDate: String, name: String, tags: [String]) {
        
        
        self.photo = photo
        self.creationDate = creationDate
        self.name = name
        self.tags = tags
        
        super.init(frame: CGRect(x: 100, y: 100, width: 100, height: 1000))
        
        setUp()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let imageView = UIImageView()
    private let textField = UITextView()
    
    func setUp() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        
        setUpPhoto()
        setUpText()
    }
    
    func setUpPhoto() {
        imageView.load(url: URL(string: photo)!)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ]
        
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    func setUpText() {
//        textField.isEnabled = false
        
        textField.text = creationDate
        textField.text = textField.text! + "\n By " + name + ", TAGS: "
        for i in tags {
            textField.text = textField.text! + " " + i
        }
        textField.font = .systemFont(ofSize: 12, weight: .bold)
        textField.textColor = .systemBackground
        textField.backgroundColor = .clear
        textField.isEditable = false
        textField.isScrollEnabled = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
                
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ]
        
        self.addSubview(textField)
        
        NSLayoutConstraint.activate(textFieldConstraints)
    }
    
}
