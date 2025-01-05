//
//  NetworkLayer.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import Foundation
import UIKit

class NetworkLayer{
    func sendRequest(prompt: String){
// Url assignment
        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "bothub.chat"
            urlComponents.path = "/api/v2/openai/v1/images/generations"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"),
                URLQueryItem(name: "model", value: "dall-e-3"),
                URLQueryItem(name: "prompt", value: prompt),
                URLQueryItem(name: "n", value: "1"),
                URLQueryItem(name: "size", value: "1024x1024")
                
            ]
        guard let reqUrl = urlComponents.url else { return }
        var urlRequest = URLRequest(url: reqUrl)
        urlRequest.httpMethod = "GET"
        
        
    }
}
