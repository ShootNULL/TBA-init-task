//
//  Loading.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 19.12.2023.
//

import Foundation
import UIKit

class LoadingView: UIViewController {
    
    override func viewDidLoad() { 
        self.view.backgroundColor = .blue
        API.shared.search()
    }
    
}
