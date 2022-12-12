//
//  Archive.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 8/14/22.
//

import Foundation

struct Archive {
    var ticks = [Int: [Transition]]()
    
    func transitions(forTick tick: Int) -> [Transition] {
        return ticks[tick] ?? [Transition]()
    }
    
    mutating func add(_ transitionsToBeAdded: [Transition], forTick tick: Int) {
        var newTransitions = transitions(forTick: tick)

        for transition in transitionsToBeAdded {
            newTransitions = insert(transition, in: newTransitions)
        }
        
        ticks[tick] = newTransitions
    }
        
    private func insert(_ appliedTransition: Transition, in transitions: [Transition]) -> [Transition] {
        var newTransitions = Array(transitions)
        
        for (index, transition) in transitions.enumerated() {
            let transitionComparison = transition.compare(to: appliedTransition)
            
            switch transitionComparison {
            case .identical:
                return newTransitions
            case .opposite:
                newTransitions.remove(at: index)
                return newTransitions
            case .distinct:
                break
            }
        }
        
        newTransitions.append(appliedTransition)
        return newTransitions
    }
}
