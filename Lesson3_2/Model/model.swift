//
//  model.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 07.01.2025.
//

import Foundation

//MARK: - common structure
struct Message: Codable{
    let role: String
    let content: String
}

//MARK: - Response struture
struct APIResponse: Decodable{
    let choices: [Choice]
}
struct Choice: Decodable{
    let message: Message
}

//MARK: - Request structure
struct APIRequest: Encodable{
    let model: String
    let messages: [Message]
}

// MARK: - Image request
struct ImgRequest: Encodable{
    let model: String
    let prompt: String
    let size: String
    let quality: String
    let n: Int
}
// MARK: - Image response
struct ImgResponse: Decodable{
//    let created: Int32
    let data: [Urls]
    
}
struct Urls: Decodable{
    let url: String
}
