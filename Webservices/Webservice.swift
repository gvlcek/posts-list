//
//  Webservice.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import Foundation

class WebServices {
    func getRequest<T: Codable>(jsonUrl: String, type: T.Type, completionHandler: @escaping ([T]) -> Void, errorHandler: @escaping (String) -> Void) {
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error as Any)
                errorHandler(error?.localizedDescription ?? "Error!")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([T].self, from: data)
                completionHandler(jsonData)
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}

