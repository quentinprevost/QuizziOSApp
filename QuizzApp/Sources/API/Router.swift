//
//  Router.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 07/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

    // MARK: Cases

    case questions(categoryID: Int)
    case categories
    case vote(parameters: Parameters)

    static let baseURLString = ""

    var method: HTTPMethod {
        switch self {
        case .questions:
            return .get
        case .categories:
            return .get
        case .vote:
            return .post
        }
    }

    var path: String {
        switch self {
        case .categories:
            return "/api/categories"
        case .questions(let categoryID):
            return "/api/question/\(categoryID)"
        case .vote:
            return "/api/answers/vote"
        }
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .vote(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }

        return urlRequest
    }
}
