//
//  ViewDataBase.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 6/30/22.
//

import Foundation
import SwiftUI

class ViewDataBase: ObservableObject {
    @Published var items = [postDataBase]()
    let prefixUrl = "http://localhost:3000"
    
    init() {
        fetchPost()
    }
    //MARK: - retrieve data
    func fetchPost() {
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("Did not find url")
            return
        }
        URLSession.shared.dataTask(with: url ) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(dataBase.self, from: data)
                    DispatchQueue.main.sync {
                        self.items = result.data
                    }
                }else {
                    print("No Data")
                }
                
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }
    //MARK: - create data
    func createPost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/createPost") else {
            print("Did not find url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url ) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(dataBase.self, from: data)
                    DispatchQueue.main.sync {
                        print(result)
                    }
                }else {
                    print("No Data")
                }
                
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }

    //MARK: - update data
    func updatePost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/updatePost") else {
            print("Did not find url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url ) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(dataBase.self, from: data)
                    DispatchQueue.main.sync {
                        print(result)
                    }
                }else {
                    print("No Data")
                }
                
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }
    //MARK: - delete data
    func deletePost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/deletePost") else {
            print("Did not find url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url ) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(dataBase.self, from: data)
                    DispatchQueue.main.sync {
                        print(result)
                    }
                }else {
                    print("No Data")
                }
                
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }

} //class end

