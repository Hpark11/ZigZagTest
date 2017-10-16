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
  static let subject = BehaviorSubject<[String: Any]>(value: [:])
  
  enum ServiceError: Error {
    case invalidPath(String)
    case invalidData(String)
    case invalidJSON(String)
  }
  
  static var week: Observable<String> = {
    return APIService.subject.asObservable()
      .map { data in
        let week = data["week"] as? String ?? ""
        return week
      }.shareReplay(1)
  }()
  
  static var shoppingMalls: Observable<[ShoppingMall]> = {
    return APIService.subject.asObservable()
      .map { data in
        let malls = data["list"] as? [[String: Any]] ?? []
        return malls.flatMap(ShoppingMall.init).sorted { $0.score > $1.score }
      }.shareReplay(1)
  }()
  
  static func request() -> [String: Any] {
    do {
      guard let path = Bundle.main.path(forResource: filename, ofType: "json", inDirectory: "zigzagRes") else {
        throw ServiceError.invalidPath("There is no Path to find \(filename).json")
      }
      
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
      guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
        let result = jsonObject as? [String: Any] else {
          throw ServiceError.invalidJSON(filename)
      }
      return result
    } catch {
      fatalError(error.localizedDescription)
    }
    return [:]
  }
}
