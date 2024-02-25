//
//  ContentView.swift
//  ScrollViews
//
//  Created by Roman Zuchowski on 25.02.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.self) var environment
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items) { item in
                        Circle()
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 10)
                            .foregroundStyle(Color.random())
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.2)
                                    .scaleEffect(
                                        x: phase.isIdentity ? 1.0 : 0.75,
                                        y: phase.isIdentity ? 1.0 : 0.75
                                    )
                                    .offset(y: phase.isIdentity ? 0 : 50)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(16, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
