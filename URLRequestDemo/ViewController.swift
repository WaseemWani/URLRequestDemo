//
//  ViewController.swift
//  URLRequestDemo
//
//  Created by Waseem Wani on 07/04/21.
//
import Foundation
import UIKit

struct ScanTicketErrorResult: Codable {
  var errors: [ScanTicketError]
}

struct ScanTicketError: Codable {
  var status: String
  var code: String
  var title: String
  var detail: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let params = ["tsn" : 123452]
        let url = URL(string: "http://der.mocklab.io/v1/ticket/scan")
        var request = URLRequest(url: url!)
        let httpBody = try? JSONSerialization.data(withJSONObject: params as Any, options: .prettyPrinted)
        request.httpBody = httpBody
        request.httpMethod = "POST"
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("error recievd \(error)")
            }
            
            if let data = data {
                let result = try? JSONDecoder().decode(ScanTicketErrorResult.self, from: data)
                print("data received", result)
            }
            print(response)
        }.resume()
    }
}

