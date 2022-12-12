//
//  Life_July_2022Tests.swift
//  Life_July_2022Tests
//
//  Created by Mike Dockerty on 7/31/22.
//

import XCTest

@testable import Life_July_2022

final class Life_July_2022Tests: XCTestCase {
    func testNeighbors() throws {
        let grid = LifeGrid(width: 3, height: 3)
        
        var point = Point(x: 1, y: 1)
        var neighbors = grid.neighbors(for: point)
        XCTAssert(neighbors.count == 8)
        
        point = Point(x: 0, y: 0)
        neighbors = grid.neighbors(for: point)
        XCTAssert(neighbors.count == 3)
        
        point = Point(x: 2, y: 1)
        neighbors = grid.neighbors(for: point)
        XCTAssert(neighbors.count == 5)
    }
    
    func testTransitions() throws {
        var archive = Archive()
        
        // Add a point
        let transition = Transition.add(Point(x: 0, y: 0))
        archive.add([transition], forTick: 0)
        XCTAssert(archive.transitions(forTick: 0).count == 1)
        
        // Add a duplicate point
        archive.add([transition], forTick: 0)
        XCTAssert(archive.transitions(forTick: 0).count == 1)

        // Add another, distinct point
        let transition2 = Transition.add(Point(x: 1, y: 0))
        archive.add([transition2], forTick: 0)
        XCTAssert(archive.transitions(forTick: 0).count == 2)
        
        // Remove a point
        let transition3 = Transition.remove(Point(x: 0, y: 0))
        archive.add([transition3], forTick: 0)
        XCTAssert(archive.transitions(forTick: 0).count == 1)
    }
    
    func testTransitionApplication() {
        var archive = Archive()
        var grid = LifeGrid(width: 5, height: 5)
        
        let pointZeroZero = Point(x: 0, y: 0)
        
        let transition = Transition.add(pointZeroZero)
        archive.add([transition], forTick: 0)
        grid.apply(archive.transitions(forTick: 0))
        
        XCTAssert(grid.cells[pointZeroZero] == true)
        
        let transition2 = Transition.remove(pointZeroZero)
        grid.apply(archive.transitions(forTick: 0))
        archive.add([transition2], forTick: 0)
        
        XCTAssert(grid.cells[pointZeroZero] == true)
        XCTAssert(archive.transitions(forTick: 0).count == 0)
        
        grid = LifeGrid(width: 5, height: 5)
        
        let testTransitions = [
            Transition.add(Point(x: 1, y: 0)),
            Transition.add(Point(x: 2, y: 1)),
            Transition.add(Point(x: 3, y: 2)),
            Transition.add(Point(x: 4, y: 3)),
        ]
        
        archive.add(testTransitions, forTick: 0)
        grid.apply(archive.transitions(forTick: 0))
        
        XCTAssert(grid.cells[Point(x: 3, y: 2)] == true)
        XCTAssert(grid.cells[Point(x: 3, y: 3)] == false)
        
        let testTransitions2 = [
            Transition.add(Point(x: 1, y: 0)),
            Transition.remove(Point(x: 2, y: 1)),
            Transition.add(Point(x: 3, y: 3)),
            Transition.add(Point(x: 4, y: 4)),
        ]
        
        archive.add(testTransitions2, forTick: 1)
        grid.apply(archive.transitions(forTick: 1))
        
        XCTAssert(grid.cells[Point(x: 3, y: 2)] == true)
        XCTAssert(grid.cells[Point(x: 2, y: 1)] == false)
        XCTAssert(grid.cells[Point(x: 3, y: 3)] == true)
    }
    
    func testTransitionGeneration() {
        var archive = Archive()
        var grid = LifeGrid(width: 5, height: 5)

        let point = Point(x: 1, y: 1)
        archive.add([Transition.add(point)], forTick: 0)
        grid.apply(archive.transitions(forTick: 0))
        
        var nextTransition = grid.nextTransition(for: point)
        XCTAssertEqual(nextTransition, .remove(point))
        
        nextTransition = grid.nextTransition(for: Point(x: 0, y: 0))
        XCTAssertNil(nextTransition)
    }
}
