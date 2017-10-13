//
//  AdditionalOperator.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

precedencegroup CompositionPrecedence {
  associativity: left
}

infix operator >>>: CompositionPrecedence

func >>> <T, U, V>(lhs: @escaping (T) -> U, rhs: @escaping (U) -> V) -> (T) -> V {
  return { rhs(lhs($0)) }
}

//func >>> <T, U, V, W>(lhs: @escaping (T) -> (U), rhs: @escaping (U, V) -> W) -> (T) -> W {
//  return { rhs(lhs($0), $1) }
//}

