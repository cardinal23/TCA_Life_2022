//
//  GridView.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 8/8/22.
//

import ComposableArchitecture
import SwiftUI

struct GridView: View {
    let store: Store<Core.State, Core.Action>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Grid(horizontalSpacing: 2.0, verticalSpacing: 2.0) {
                ForEach(0..<viewStore.lifeGrid.height, id: \.self) { y in
                    GridRow {
                        ForEach(0..<viewStore.lifeGrid.width, id: \.self) { x in
                            let point = Point(x: x, y: y)
                            let isAlive = viewStore.lifeGrid.cells[point] ?? false
                            let livingNeighborCount = viewStore.lifeGrid.livingNeighbors(for: point)
                            cellView(
                                x: x,
                                y: y,
                                isAlive: isAlive,
                                livingNeighborCount: livingNeighborCount,
                                viewStore: viewStore
                            )
                        }
                    }
                }
            }
        }
    }
}

func cellView(
    x: Int,
    y: Int,
    isAlive: Bool,
    livingNeighborCount: Int,
    viewStore: ViewStore<Core.State, Core.Action>
) -> some View {
    let tap = TapGesture()
        .onEnded { _ in
            viewStore.send(.cellTapped(x: x, y: y))
        }
    
    var imageName = "\(livingNeighborCount).circle"
    if isAlive {
        imageName += ".fill"
    }
    
    return Image(systemName: imageName).gesture(tap)
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(
            store: Store(
                initialState: Core.State(
                    lifeGrid: LifeGrid(
                        width: 5,
                        height: 5
                    )
                ),
                reducer: Core()
            )
        )
    }
}
