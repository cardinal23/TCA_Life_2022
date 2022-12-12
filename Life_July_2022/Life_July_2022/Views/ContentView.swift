//
//  ContentView.swift
//  Life_July_2022
//
//  Created by Mike Dockerty on 7/31/22.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store = Store(
        initialState: Core.State(),
        reducer: Core()
    )
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Spacer()
                GridView(store: store)
                Spacer()
                HStack {
                    Button(action: {
                        viewStore.send(.tickBackward)
                    }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                    Text("\(viewStore.tick)")
                        .fontWeight(.semibold)
                        .font(.title)
                        .padding()
                    
                    Button(action: {
                        viewStore.send(.tickForward)
                    }) {
                        Image(systemName: "chevron.forward.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
