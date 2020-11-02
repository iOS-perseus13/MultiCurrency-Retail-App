//
//  RequestManager.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
protocol RequestManagerType {
    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)

    func fetchMetaData(with request: URLRequest,
                       completion: @escaping (Result< (URLResponse, Data), APIError>) ->Void)
    
}

class RequestManager: NSObject, RequestManagerType {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

   func decodingTask<T: Decodable>(with request: URLRequest,
                                   decodingType: T.Type,
                                   completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            switch httpResponse.statusCode {
            case 200:
                guard httpResponse.mimeType == "application/json" else {
                    completion(nil, .invalidData)
                    return
                }
                guard let data = data else {
                    completion(nil, .invalidData)
                    return
                }

               // let json =  try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                do {
                    let genericModel = try JSONDecoder().decode(decodingType, from: data)
                    completion(genericModel , nil)
                }
                catch {
                    completion(nil, .jsonConversionFailure)
                }
            case 400:
                completion(nil, .badRequest)
            case 401:
                print("API call need proper authentication: Status code \(httpResponse.statusCode)")
                completion(nil, .unauthorized)
            case 500:
                completion(nil, .internalServerError)
            default:
                completion(nil, .other(message: "Error \(httpResponse.statusCode)"))
            }
        }
        return task
    }
    
    func fetchMetaData(with request: URLRequest,
                       completion: @escaping (Result< (URLResponse, Data), APIError>) -> Void) {

        let task = session.dataTask(with: request) { (data, response, _) in


            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }

            switch httpResponse.statusCode {
            case 200:
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success((httpResponse, data)))
            case 400:
                completion(.failure(.badRequest))

            case 401:
                completion(.failure(.unauthorized))

            case 500:
                completion(.failure(.internalServerError))
            default:
                completion(.failure(.other(message: "Error \(httpResponse.statusCode)")))
            }
        }
       task.resume()
    }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request,
                                decodingType: T.self) { json, error in
            // MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
               
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}

