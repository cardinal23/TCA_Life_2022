//
//  Core.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 8/9/22.
//

import ComposableArchitecture

struct Core: ReducerProtocol {
    struct State: Equatable {
        var lifeGrid = LifeGrid(width: 5, height: 5)
        var tick = 0
    }

    enum Action: Equatable {
        case cellTapped(x: Int, y: Int)
        case tickForward
        case tickBackward
    }
    
    func reduce(
        into state: inout State,
        action: Action
    ) -> ComposableArchitecture.Effect<Action, Never> {
        switch action {
        case .cellTapped(x: let x, y: let y):
            state.lifeGrid.toggleState(for: Point(x: x, y: y))
            return .none
        case .tickForward:
            state.tick += 1
            return .none
        case .tickBackward:
            state.tick -= 1
            if state.tick < 0 {
                state.tick = 0
            }
            return .none
        }
        
    }
}
