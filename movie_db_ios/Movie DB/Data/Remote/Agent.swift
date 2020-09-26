//
//  Agent.swift
//  iOS
//
//  Created by Myo Zaw Oo on 04/08/2020.
//

import Combine
import Foundation

struct Agent {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (result: (data: Data, response: URLResponse)) -> Response<T> in

                guard let response = result.response as? HTTPURLResponse else {
                    throw ApiError.init(errorMessage: "Unknown Response")
                }
                
                if response.statusCode == 401 {
                    throw ApiError.init(errorMessage: "Unauthorized.")
                }
                
                if response.statusCode == 404 {
                    throw ApiError.init(errorMessage: "Bad request.")
                }
                
                do {
                    let value = try decoder.decode(T.self, from: result.data)
                    print("Data: \(value)")
                    return Response(value: value, response: response)
                } catch let error {
                    throw ApiError.init(errorMessage: "Unknown Error \(error)")
                }
                
                
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        if let message = String(data: data!, encoding: .nonLossyASCII){
            return message
        }
        return ""
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8)
        return text!
    }
    
    
}
