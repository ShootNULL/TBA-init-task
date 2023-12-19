//
//  Models.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 18.12.2023.
//

import Foundation

struct TopResults: Codable {
    var total: Int
    var results: [pinCard]
}
struct pinCard: Codable {
    var id: String
    var description: String?
    var created_at: String?
    var user: UserCard
    var urls: URLs
}
struct URLs: Codable {
    var small: String
}
struct UserCard: Codable {
    var name: String
}



struct FindPhoto: Codable {
    var id: String
    var tags: [TagTitles]
}

struct TagTitles: Codable {
    var title: String
}

struct TagSearch: Codable {
//    var id: String
//    var description: String
//    var created_at: String
//    var user: UserCard
//    var urls: URLs
}
