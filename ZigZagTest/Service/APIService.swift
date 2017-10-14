//
//  APIService.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 14..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct APIService {
  static let filename: String = "shopList"
  
  enum ServiceError: Error {
    case invalidPath(String)
    case invalidData(String)
    case invalidJSON(String)
  }
  
  static func request() -> Observable<[String: Any]> {
    return Observable.create { observer in
      guard let path = Bundle.main.path(forResource: filename, ofType: "json", inDirectory: "zigzagRes") else {
        observer.onError(ServiceError.invalidPath("zigzagRes/\(filename).json"))
        return Disposables.create()
      }
      
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
          let result = jsonObject as? [String: Any] else {
            throw ServiceError.invalidJSON(filename)
        }
        
        observer.onNext(result)
        observer.onCompleted()
      } catch {
        observer.onError(ServiceError.invalidData(filename))
      }
      return Disposables.create()
    }
  }
  
//  static var categories: Observable<[EOCategory]> = {
//    return EONET.request(endpoint: categoriesEndpoint)
//      .map { data in
//        let categories = data["categories"] as? [[String: Any]] ?? []
//        return categories
//          .flatMap(EOCategory.init)
//          .sorted { $0.name < $1.name }
//      }
//      .shareReplay(1)
//  }()
  
  static var week: Observable<String> {
    return .just("")
  }
  
  //static var shoppingMalls: Observable
  
  
  
  
}
