//
//  JsonStructs.swift
//  WordsFactory
//
//  Created by SHREDDING on 12.07.2023.
//

import Foundation

// MARK: - DictResponse
struct DictResponse: Codable {
    let def: [Def]
}

// MARK: - Def
struct Def: Codable {
    let text:String
    let pos:String?
    let ts: String?
    let tr: [Tr]?
}

// MARK: - Tr
struct Tr: Codable {
    let text:String
    let pos:String?
    let ts: String?
    let syn: [Syn]?
    let mean: [Mean]?
}

// MARK: - Mean
struct Mean: Codable {
    let text: String
}

// MARK: - Syn
struct Syn: Codable {
    let text:String
    let pos: String?
}
