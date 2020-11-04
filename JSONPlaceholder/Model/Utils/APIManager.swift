//
//  APIManager.swift
//  JSONPlaceholder
//
//  Created by Wii Lin on 2020/11/4.
//

import Foundation
import RxAlamofire
import RxSwift

class APIManager: NSObject {
    static let shared: APIManager = APIManager()
    let disposeBag = DisposeBag()
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func getAlbum(completionHandler: @escaping (Result<[Album], NSError>) -> Void) {
        RxAlamofire.requestData(.get, URL(string: "https://jsonplaceholder.typicode.com/photos")!)
            .subscribe(onNext: { [weak self] (r, data) in
                guard let self = self else { return }
                do {
                    let response = try self.jsonDecoder.decode([Album].self, from: data)
                    completionHandler(.success(response))
                } catch {
                    print("JSONDecoder Error\(error)")
                    completionHandler(.failure(error as NSError))
                }
            }, onError: { (error) in
                completionHandler(.failure(error as NSError))
            })
            .disposed(by: disposeBag)
    }
    
}
