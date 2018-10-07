//
//  GenerateNumberAPI.swift
//  PLDemo
//
//  Created by Aisha on 6/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import Foundation
struct RandomNum: Codable {
    let id: Int
    let number: String
}

struct GetAllNum: RequestType {
    var max : String
    typealias ResponseType = [RandomNum]
    var data: RequestData {
        return RequestData(path: "https://www.random.org/sequences/?min=1&max=" + max + "&col=1&format=plain&rnd=new")
    }
}

extension Array where Element == RandomNum {
    var numbers: [String] {
        return map { $0.number }
    }
}

extension Array where Element == String {
    func printAll() {
        forEach { print("num: \($0)") }
    }
}

extension Error {
    func printDescription() {
        print(self)
    }
}


/* func requestNumbers() {
 
 var request = URLRequest(url: URL(string: kBaseURL + numberField.text! + kParam )!)
 request.httpMethod = "GET"
 let task = URLSession.shared.dataTask(with: request) { data, response, error in
 guard let data = data, error == nil else {                                                 // check for fundamental networking error
 print("error=\(String(describing: error))")
 return
 }
 
 if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
 print("statusCode should be 200, but is \(httpStatus.statusCode)")
 print(response ?? "")
 }
 
 let responseString = String(data: data, encoding: .utf8)
 print(responseString as Any)
 self.numberGenerated = responseString
 
 }
 
 task.resume()
 
 }*/
