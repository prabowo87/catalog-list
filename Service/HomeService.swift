//
//  HomeService.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//
import Combine
import Foundation
class HomeService {

    static let shared = HomeService()

    func getProducts() -> AnyPublisher<ResponseProductModel, Error> {
        guard let url = URL(string: "\(Constants.BASE_URL)products") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let response = try JSONDecoder().decode(ResponseProductModel.self, from: data)
                        return promise(.success(response))
                    } catch let error {
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
}
