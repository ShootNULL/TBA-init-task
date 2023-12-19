//
//  API.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 18.12.2023.
//

import Foundation
import UIKit

class API: ObservableObject {
    static let shared = API()
    
    private var token = "d0i09Qd2sLN8TgeA53IuaEAtEi7MFwm_byhGS9e84ro"
    var results = [pinCard]()
    var tags = [FindPhoto]()
    private var searchText: String = "flowers"
    
    func search() {
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(TopResults.self, from: data)
                self.results.append(contentsOf: res.results)
                
                for i in self.results { self.getPhoto(id: i.id) }
                    
                print("Done")
                
                DispatchQueue.main.async {
                    let vc = UIApplication.getTopViewController()
                    let newVC = MainViewController()
                    newVC.modalPresentationStyle = .fullScreen
                    
                    vc?.present(newVC, animated: true)
                    print("Gone")
                }
                

            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getPhoto(id: String) {
        let url = URL(string: "https://api.unsplash.com/photos/" + id)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(FindPhoto.self, from: data)
                self.tags.append(res)
//                print(res.tags)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getTags(number: Int) -> [String] {
        if self.tags.count == 0 { return [] }
        
        var result: [String] = []
        for i in self.tags[number].tags {
            result.append(i.title)
        }
        return result
    }
}


