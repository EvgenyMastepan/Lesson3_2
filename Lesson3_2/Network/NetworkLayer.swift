//
//  NetworkLayer.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import Foundation
class NetworkLayer{
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
    func sendRequest(prompt: String, completion: @escaping ([Choice]) -> Void){
// Url assignment
        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "bothub.chat"
//            urlComponents.path = "/api/v2/openai/v1/images/generations"
            urlComponents.path = "/api/v2/openai/v1/chat/completions/"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "model", value: "dall-e-3"),
                URLQueryItem(name: "prompt", value: prompt),
                URLQueryItem(name: "n", value: "1"),
                URLQueryItem(name: "size", value: "1024x1024")
                
            ]
        guard let reqUrl = urlComponents.url else { return }
        var urlRequest = URLRequest(url: reqUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "model": "gpt-40",
            "messges": [
                ["role": "system", "content": "You are smart companion."],
                ["role": "user", "content": "Hallo!"]
            ]
        ]
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            guard error == nil, let data = data else { return }
            do{
                let results = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(results.choices)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
