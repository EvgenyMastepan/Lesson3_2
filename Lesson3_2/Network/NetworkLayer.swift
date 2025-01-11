//
//  NetworkLayer.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import Foundation

// MARK: - Class about work with net.
class NetworkLayer{
// Api Key. May be add this in settings?
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
// MARK: - Main functrion for excange data with text server.
    func sendRequest(prompt: String, completion: @escaping ([Choice]) -> Void){
        
        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "bothub.chat"
            urlComponents.path = "/api/v2/openai/v1/chat/completions/"
        guard let reqUrl = urlComponents.url else { return }
        var urlRequest = URLRequest(url: reqUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            let bodyStruct = APIRequest(model: "gpt-4o", messages: [
                Message(role: "system", content: "You are professional programmer"),
                Message(role: "user", content: prompt)
            ])
            do{
                let body = try JSONEncoder().encode(bodyStruct)
                urlRequest.httpBody = body
            } catch {
                print(error.localizedDescription)
            }
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
    
// MARK: - Main function for excange data with image server.
        func sendImgRequest(prompt: String, completion: @escaping ([Urls]) -> Void){
            
            var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "bothub.chat"
                urlComponents.path = "/api/v2/openai/v1/images/generations/"
            guard let reqUrl = urlComponents.url else { return }
            var urlRequest = URLRequest(url: reqUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

                let bodyImgStruct = ImgRequest(model: "dall-e-3",
                                               prompt: prompt,
                                               size: "1024x1024",
                                               quality: "standard",
                                               n: 1)
                do{
                    let body = try JSONEncoder().encode(bodyImgStruct)
                    urlRequest.httpBody = body
                } catch {
                    print(error.localizedDescription)
                }
            
            URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                guard error == nil, let data = data else { return }
                do{
                        let results = try JSONDecoder().decode(ImgResponse.self, from: data)
                    completion(results.data)
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
          }
}
