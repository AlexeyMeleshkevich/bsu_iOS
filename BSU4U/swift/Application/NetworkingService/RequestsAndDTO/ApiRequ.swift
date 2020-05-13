//
//  ApiRequ.swift
//  tableSettigins
//
//  Created by Владимир Лишаненко on 1/6/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responceProblem
    case decodingProblem
    case other
}


struct ApiRequest {
    let resourse: URL
    init(endpoint: String) {
        let resourseString = "http://93.125.18.58:8080/\(endpoint)"
        guard let resourse = URL(string: resourseString) else { fatalError() }
        self.resourse = resourse
    }
    func login(_ loginData:Login, completion: @escaping(Result<Token, APIError>) -> Void) {
        let parametrs = ["login" : loginData.login!, "password" : loginData.password!, "device_id" : loginData.deviceID!]
       
        var request = URLRequest(url: resourse)
        request.httpMethod = "POST"
       
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                 print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(Token.self, from: data)
                let token = json.token
                UserDefaults.standard.set(token, forKey: "Token")
                UserDefaults.standard.synchronize()
                completion(.success(json))
            } catch {
                completion(.failure(.decodingProblem))
                print(error)
            }
        }.resume()
    }

    func getPrivateProfile(completion: @escaping(Result<Profile, APIError>) -> Void) {
        var request = URLRequest(url: resourse)
        let token = UserDefaults.standard.object(forKey: "Token") as? String
        let auth = "Bearer \(token)"
        print(auth)
        request.setValue(auth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(Profile.self, from: data)
                let profile = json.self
                completion(.success(profile))
            } catch {
                completion(.failure(.decodingProblem))
                print(error)
            }
        }.resume()
    }
    func getLesson(completion: @escaping(Result<[CalendarForDay], APIError>) -> Void) {
        var request = URLRequest(url: resourse)
        let token = UserDefaults.standard.object(forKey: "Token") as? String
        let auth = "Bearer \(token)"
        print(auth)
        request.setValue(auth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
                
            guard let data = data else { return }
        
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode([CalendarForDay].self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(.decodingProblem))
                print(error)
            }
        }.resume()
    }
}

