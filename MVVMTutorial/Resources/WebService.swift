//
//  WebService.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/17/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import Foundation


enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

fileprivate struct Response<T: Codable>: Codable {
    let message: String
    let data: T
    let success: Bool
}


class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) ->Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMehtod.rawValue
        request.httpBody = resource.body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.data))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
