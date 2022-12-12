//
//  Grid.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 8/2/22.
//

import Foundation

struct LifeGrid: Equatable {
    var cells = [Point: Bool]()
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        for x in 0..<width {
            for y in 0..<height {
                let point = Point(x: x, y: y)
                cells[point] = false
            }
        }
    }
    
    func livingNeighbors(for point: Point) -> Int {
        return neighbors(for: point).reduce(0, { count, point in
            let isAlive = cells[point] ?? false
            return count + (isAlive ? 1 : 0)
        })
    }
    
    /// Returns neighbor points that exist within the grid bounds
    func neighbors(for point: Point) -> [Point] {
        var neighbors = [Point]()
        
        neighbors.append(Point(x: point.x - 1, y: point.y - 1))
        neighbors.append(Point(x: point.x, y: point.y - 1))
        neighbors.append(Point(x: point.x + 1, y: point.y - 1))
        neighbors.append(Point(x: point.x - 1, y: point.y))
        neighbors.append(Point(x: point.x + 1, y: point.y))
        neighbors.append(Point(x: point.x - 1, y: point.y + 1))
        neighbors.append(Point(x: point.x, y: point.y + 1))
        neighbors.append(Point(x: point.x + 1, y: point.y + 1))
        
        neighbors = neighbors.filter { point in
            point.x >= 0 &&
            point.x < width &&
            point.y >= 0 &&
            point.y < height
        }
        
        return neighbors
    }
    
    mutating func toggleState(for point: Point) {
        let isAlive = cells[point] ?? false
        let toggleTransition: Transition = isAlive ? .remove(point) : .add(point)
        print(toggleTransition)
        cells[point] = !isAlive
    }
    
    private mutating func apply(_ transition: Transition) {
        switch transition {
            
        case .add(let point):
            cells[point] = true
        case .remove(let point):
            cells[point] = false
        }
    }
    
    mutating func apply(_ transitions: [Transition]) {
        for transition in transitions {
            apply(transition)
        }
    }
    
    func generateTransitionsForNextTick() -> [Transition] {
        var transitions = [Transition]()
        
        for (point, _) in cells {
            if let nextTransition = nextTransition(for: point) {
                transitions.append(nextTransition)
            }
        }
        
        return transitions
    }
    
    func nextTransition(for point: Point) -> Transition? {
        let isAlive = cells[point] ?? false
        let numberOfNeighbors = livingNeighbors(for: point)
        
        switch numberOfNeighbors {
        case 0..<2:
            return isAlive ? Transition.remove(point) : nil
        case 2:
            return nil
        case 3:
            return isAlive ? nil : Transition.add(point)
        default:
            return isAlive ? Transition.remove(point) : nil
        }
    }
}
