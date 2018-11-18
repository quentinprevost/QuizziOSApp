//
//  Networker.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 07/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation
import Alamofire

protocol WebServiceProtocol {
    func request<T>(for type: T.Type, route: Router, completion: ((T?, Error?) -> Void)?) where T: Codable
}

final class WebService: WebServiceProtocol {

    // MARK: - Properties
    private let jsonDecoder: JSONDecoder

    init() {
        jsonDecoder = JSONDecoder()
    }

    func request<T>(for type: T.Type, route: Router, completion: ((T?, Error?) -> Void)?) where T: Codable {
        Alamofire.request(route).responseJSON { response in
            guard let json = response.data else {
                completion?(nil, response.error)
                return
            }

            do {
                let result = try self.jsonDecoder.decode(T.self, from: json)
                completion?(result, nil)
            } catch {
                completion?(nil, error)
            }
        }
    }
}
