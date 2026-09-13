//
//  HomeView.swift
//  MoviePulse
//
//  Created by Sergio Gómez García on 08/09/2026.
//

import SwiftUI

struct HomeView: View {
    let store: HomeStore

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(store.state.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text(store.state.subtitle)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }

                Section("Roadmap inicial") {
                    ForEach(store.state.plannedSections, id: \.self) { section in
                        Label(section, systemImage: "film")
                    }
                }
            }
        }
        .onAppear {
            store.process(.appear)
        }
    }
}

#Preview {
    HomeView(store: HomeStore())
}
