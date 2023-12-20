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
    
    private func getPhoto(id: String) {
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
        
//        print(self.tags[0])
        
        if self.tags.count < number - 2 { return [] }
        print(self.tags.count)
        print(self.tags[number], number)
        
        var result: [String] = []
        for i in self.tags[number].tags {
            result.append(i.title)
        }
        return result
        
        
    }
    
    func searchTag(tag: String) {
        let url = URL(string: "https://api.unsplash.com/topics/" + tag + "/photos")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode([pinCard].self, from: data)
//                let kek = String(data: data, encoding: .utf8)
                
                self.results = []
                self.results = res
//                let arr = []
//                arr.append(res)
                print(res)
                
//                print(self.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}


