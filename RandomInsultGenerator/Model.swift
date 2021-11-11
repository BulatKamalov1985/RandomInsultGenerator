//
//  Model.swift
//  RandomInsultGenerator
//
//  Created by Bulat Kamalov on 11.11.2021.
//

import Foundation

// MARK: - InsultsModel
struct FuckYouElements: Codable {
    let number: String?
    let language: String?
    let insult: String?
    let created: String?
    let shown: String?
    let createdby: String?
    let active: String?
    let comment: String?
}

enum URLS: String {
    case urlString = "https://evilinsult.com/generate_insult.php?lang=en&type=json"
    
}
