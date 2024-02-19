//
//  URLSessionNetworkService.swift
//  CleanPokedex
//
//  Created by 홍승완 on 2024/02/17.
//

import Foundation
import RxSwift

private enum HTTPMethod {
    static let get = "GET"
}

enum URLSessionNetworkServiceError: Int, Error {
    var description: String { self.errorDescription }

    case responseDecodingError
    case invalidURLError
    case unknownError
    case emptyDataError
    
    var errorDescription: String {
        switch self {
        case .invalidURLError: return "INVALID_URL_ERROR"
        case .responseDecodingError: return "RESPONSE_DECODING_ERROR"
        case .unknownError: return "UNKNOWN_ERROR"
        case .emptyDataError: return "EMPTYDATA_ERROR"
        }
    }
}

protocol URLSessionNetworkService {
    func decode<T: Decodable>(data: Data, to target: T.Type) -> T?
    func get(
        url urlString: String
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>>

}

extension URLSessionNetworkService {
    func get(
        url urlString: String
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return self.request(url: urlString, method: HTTPMethod.get)
    }
    
    func decode<T: Decodable>(data: Data, to target: T.Type) -> T? {
        return try? JSONDecoder().decode(target, from: data)
    }
}

extension URLSessionNetworkService {
    private func request(
        url urlString: String,
        method: String
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        guard let url = URL(string: urlString) else {
            return Observable.error(URLSessionNetworkServiceError.invalidURLError)
        }
        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
            let request = self.createHTTPRequest(of: url, httpMethod: method)
            let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
                guard let httpResponse = reponse as? HTTPURLResponse else {
                    emitter.onError(URLSessionNetworkServiceError.unknownError)
                    return
                }
                
                if error != nil {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }

                guard let data = data else {
                    emitter.onNext(.failure(.emptyDataError))
                    return
                }
                emitter.onNext(.success(data))
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return URLSessionNetworkServiceError(rawValue: errorCode)
        ?? URLSessionNetworkServiceError.unknownError
    }
    
    private func createHTTPRequest(
        of url: URL,
        httpMethod: String
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod

        return request
    }

}
