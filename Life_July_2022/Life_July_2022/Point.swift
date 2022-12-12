//
//  Point.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 8/2/22.
//

import Foundation

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
}

extension Point: CustomStringConvertible {
    var description: String {
        "(\(x),\(y))"
    }
}
