//
//  Transition.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 9/5/22.
//

import Foundation

enum Transition: Equatable {
    case add(Point)
    case remove(Point)
    
    enum Comparison {
        /// Same point, same action
        case identical
        
        /// Same point, opposite action
        case opposite
        
        /// Different point
        case distinct
    }
    
    func compare(to transition: Transition) -> Comparison {
        switch self {
        case .add(let comparisonPoint):
            switch transition {
            case .add(let point):
                if point == comparisonPoint {
                    return .identical
                } else {
                    return .distinct
                }
            case .remove(let point):
                if point == comparisonPoint {
                    return .opposite
                } else {
                    return .distinct
                }
            }
        case .remove(let comparisonPoint):
            switch transition {
            case .add(let point):
                if point == comparisonPoint {
                    return .opposite
                } else {
                    return .distinct
                }
            case .remove(let point):
                if point == comparisonPoint {
                    return .identical
                } else {
                    return .distinct
                }
            }
        }
    }
    
    func reverse() -> Transition {
        switch self {
        case .add(let point):
            return Transition.remove(point)
        case .remove(let point):
            return Transition.add(point)
        }
    }
}

extension Transition: CustomStringConvertible {
    var description: String {
        switch self {
        case .add(let point):
            return "Add \(point)"
        case .remove(let point):
            return "Remove \(point)"
        }
    }
}
