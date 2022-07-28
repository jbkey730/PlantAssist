//
//  ViewDataBase.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 6/30/22.
//

import Foundation
import SwiftUI
import UIKit

class ViewDataBase: ObservableObject {
    @Published var items = [postDataBase]()
    let prefixUrl = "https://mlbroadvisions.com"
    //let prefixUrl = "https://jsonplaceholder.typicode.com/posts"
    init() {
        fetchPost()
    }
    //MARK: - retrieve data
    func fetchPost() {
        guard let url = URL(string: "\(prefixUrl)/service.php") else{
            print("Did not find url")
            return
        }
        //var request = URLRequest(url: url)
        //request.httpMethod = "GET"
      
        //let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
       URLSession.shared.dataTask(with: url ) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data , let dataString = NSString(data:data, encoding: String.Encoding.utf8.rawValue) {
                    print("response to dataString \(dataString)")
                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
                        DispatchQueue.main.sync {
                                        self.items = result
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
//        guard let url = URL(string: "\(prefixUrl)/post.php") else {
//            print("Did not find url")
//            return
//        }
        
    
//        let dictValues = [Any](parameters.values)
//
//        let postString = "title=\(dictValues[0] as? Text)&post=\(dictValues[1] as? Text)"
//
//        //var request = URLRequest(url: url)
//        let request = NSMutableURLRequest(url: NSURL(string: "\(prefixUrl)/post.php")! as URL)
//
//        request.httpMethod = "POST"
//        //request.httpBody = data
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//       // request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        print("json serialization data is coded as: ", postString)
//
//       print("json serialization request is coded as: ", request)
//
//        let task =  URLSession.shared.dataTask(with: request as URLRequest ) { (data, res, error) in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
////            do {
//            if let data = data, let dataString = NSString(data:data, encoding: String.Encoding.utf8.rawValue) {
//                print("response to dataString \(dataString)")
////                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
////                    DispatchQueue.main.sync {
////                        self.items = result
////                    }
////                }else {
////                    print("No Data")
////                }
//        }
////            } catch let JsonError {
////                print("fetch json error:", JsonError.localizedDescription)
////            }
//
//        }
//        task.resume()
        
        //-----------------------------------------------------------
        
        guard let url = URL(string: "\(prefixUrl)/post.php") else {
            print("Did not find url")
            return
        }
        
        let dataParam = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = dataParam
        //request.httpBody = parameters.data(using: String.Encoding.utf8)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Encoding")
        request.setValue("application/json", forHTTPHeaderField: "Date")
        request.setValue("application/json", forHTTPHeaderField: "Server")
        request.setValue("application/json", forHTTPHeaderField: "Vary")
        request.setValue("application/json", forHTTPHeaderField: "cf-cache-status")
        request.setValue("application/json", forHTTPHeaderField: "cf-ray")
        request.setValue("application/json", forHTTPHeaderField: "expect-ct")
        request.setValue("application/json", forHTTPHeaderField: "host-header")

//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Basic htu574kfj584kfnd84kdlwut92jayebgpylg8md72msgrk", forHTTPHeaderField: "Authorization")
//
        print("json serialization data is coded as: ", parameters)
        //
        print("json serialization request is coded as: ", dataParam)
        
        URLSession.shared.dataTask(with: request ) { (data, res, error) in
            if error != nil {
                print("urlsession error is coded as: ", error?.localizedDescription ?? "")
                return
            }
            
            print("urlsession data is coded as: ", data!)
            
            print("urlsession results is coded as: ", res!)

            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
//                    DispatchQueue.main.sync {
//                        print(result)
//                    }
//                }else {
//                    print("No Data")
//                }
                
                if let data = data, let dataString = NSString(data:data, encoding: String.Encoding.utf8.rawValue) {
                    print("response to dataString \(dataString)")
                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
                        DispatchQueue.main.sync {
                                        self.items = result
                                    }
                    }else {
                        print("No Data")
                                }


            }catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
                //print("error is \(error)")

                print("json data is coded as: ", data!)
            }
            print("json data is coded as: ", data!)

        }.resume()
//
//            do {
//                      if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
//
//                           // Print out entire dictionary
//                           print(convertedJsonIntoDict)
//
//                           // Get value by key
//                           let userId = convertedJsonIntoDict["ID"]
//                           print(userId ?? "userId could not be read")
//
//                       }
//            } catch let error as NSError {
//                       print(error.localizedDescription)
//
//            }
//            print("json data is coded as: ", data!)
//
//        }.resume()
    }

    //MARK: - update data
    func updatePost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/update.php") else {
            print("Did not find url")
            return
        }
        
        let dataParam = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = dataParam
        //request.httpBody = parameters.data(using: String.Encoding.utf8)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Encoding")
        request.setValue("application/json", forHTTPHeaderField: "Date")
        request.setValue("application/json", forHTTPHeaderField: "Server")
        request.setValue("application/json", forHTTPHeaderField: "Vary")
        request.setValue("application/json", forHTTPHeaderField: "cf-cache-status")
        request.setValue("application/json", forHTTPHeaderField: "cf-ray")
        request.setValue("application/json", forHTTPHeaderField: "expect-ct")
        request.setValue("application/json", forHTTPHeaderField: "host-header")

//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Basic htu574kfj584kfnd84kdlwut92jayebgpylg8md72msgrk", forHTTPHeaderField: "Authorization")
//
        print("json serialization data is coded as: ", parameters)
        //
        print("json serialization request is coded as: ", dataParam)
        
        URLSession.shared.dataTask(with: request ) { (data, res, error) in
            if error != nil {
                print("urlsession error is coded as: ", error?.localizedDescription ?? "")
                return
            }
            
            print("urlsession data is coded as: ", data!)
            
            print("urlsession results is coded as: ", res!)

            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
//                    DispatchQueue.main.sync {
//                        print(result)
//                    }
//                }else {
//                    print("No Data")
//                }
                
                if let data = data, let dataString = NSString(data:data, encoding: String.Encoding.utf8.rawValue) {
                    print("response to dataString \(dataString)")
                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
                        DispatchQueue.main.sync {
                                        self.items = result
                                    }
                    }else {
                        print("No Data")
                                }


            }catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
                //print("error is \(error)")

                print("json data is coded as: ", data!)
            }
            print("json data is coded as: ", data!)

        }.resume()
        
    }
    //MARK: - delete data
    func deletePost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/delete.php") else {
            print("Did not find url")
            return
        }
        
        let dataParam = try! JSONSerialization.data(withJSONObject: parameters)

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = dataParam
        //request.httpBody = parameters.data(using: String.Encoding.utf8)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Encoding")
        request.setValue("application/json", forHTTPHeaderField: "Date")
        request.setValue("application/json", forHTTPHeaderField: "Server")
        request.setValue("application/json", forHTTPHeaderField: "Vary")
        request.setValue("application/json", forHTTPHeaderField: "cf-cache-status")
        request.setValue("application/json", forHTTPHeaderField: "cf-ray")
        request.setValue("application/json", forHTTPHeaderField: "expect-ct")
        request.setValue("application/json", forHTTPHeaderField: "host-header")

//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Basic htu574kfj584kfnd84kdlwut92jayebgpylg8md72msgrk", forHTTPHeaderField: "Authorization")
//
        print("json serialization data is coded as: ", parameters)
        //
        print("json serialization request is coded as: ", dataParam)
        
        URLSession.shared.dataTask(with: request ) { (data, res, error) in
            if error != nil {
                print("urlsession error is coded as: ", error?.localizedDescription ?? "")
                return
            }
            
            print("urlsession data is coded as: ", data!)
            
            print("urlsession results is coded as: ", res!)

            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
//                    DispatchQueue.main.sync {
//                        print(result)
//                    }
//                }else {
//                    print("No Data")
//                }
                
                if let data = data, let dataString = NSString(data:data, encoding: String.Encoding.utf8.rawValue) {
                    print("response to dataString \(dataString)")
                    let result = try JSONDecoder().decode([postDataBase].self, from: data)
                        DispatchQueue.main.sync {
                                        self.items = result
                                    }
                    }else {
                        print("No Data")
                                }


            }catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
                //print("error is \(error)")

                print("json data is coded as: ", data!)
            }
            print("json data is coded as: ", data!)

        }.resume()
    }

} //class end

