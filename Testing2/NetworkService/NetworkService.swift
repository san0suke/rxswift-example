//
//  NetworkService.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 31/10/24.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class NetworkService {
    
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    private func request<T: Decodable>(method: HTTPMethod, endpoint: String, parameters: [String: Any]? = nil) -> Observable<T> {
        let url = "\(baseURL)\(endpoint)"
        
        return RxAlamofire.requestData(method, url, parameters: parameters, encoding: JSONEncoding.default)
            .flatMap { response, data -> Observable<Data> in
                if (200..<300).contains(response.statusCode) {
                    return Observable.just(data)
                } else {
                    return Observable.error(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code \(response.statusCode)"]))
                }
            }
            .map { data in
                return try JSONDecoder().decode(T.self, from: data)
            }
            .catchError { _ in
                if T.self == String.self {
                    return Observable.just("" as! T)
                } else if T.self == Int.self {
                    return Observable.just(0 as! T)
                } else if T.self == Array<Any>.self {
                    return Observable.just([] as! T)
                } else {
                    return Observable.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No default value available for type \(T.self)"]))
                }
            }
    }
    
    func get<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil) -> Observable<T> {
        return request(method: .get, endpoint: endpoint, parameters: parameters)
    }
    
    func post<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil) -> Observable<T> {
        return request(method: .post, endpoint: endpoint, parameters: parameters)
    }
    
    func put<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil) -> Observable<T> {
        return request(method: .put, endpoint: endpoint, parameters: parameters)
    }
    
    func delete<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil) -> Observable<T> {
        return request(method: .delete, endpoint: endpoint, parameters: parameters)
    }
}
