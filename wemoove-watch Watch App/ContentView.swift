//
//  ContentView.swift
//  wemoove-watch Watch App
//
//  Created by mac on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    // Lee userId y jwt de UserDefaults
    @State private var userId: Int = UserDefaults.standard.integer(forKey: "userId")
    @State private var jwt: String = UserDefaults.standard.string(forKey: "jwt") ?? ""

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(activities, id: \.id) { item in
                        NavigationLink(destination: ActivityScreen(
                            activity: item.name,
                            icon: item.icon,
                            userId: userId,  // Pasa userId
                            jwt: jwt  // Pasa jwt
                        )) {
                            ActivityButton(item: item)
                        }
                    }
                }
            }
            // Modelo simple para actividades — si lo prefieres, mueve esto a un ViewModel
            let activities: [ActivityItem] = [
                ActivityItem(id: 1, icon: "figure.walk", label: "Walk"),
                ActivityItem(id: 2, icon: "figure.run", label: "Run"),
                ActivityItem(id: 3, icon: "bicycle", label: "Bike"),
                ActivityItem(id: 4, icon: "figure.pool.swim", label: "Swim"),
                // Puedes añadir más items aquí o cargarlos dinámicamente
            ]

            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 102/255, green: 0/255, blue: 255/255),
                        Color(red: 102/255, green: 0/255, blue: 255/255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .ignoresSafeArea()

                // Scrollable list of activity buttons
                ScrollView(.vertical) {
                    LazyVStack(spacing: 8) {
                        ForEach(activities, id: \ .id) { item in
                            ActivityButton(icon: item.icon, label: item.label)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

// Simple struct para modelar un item de actividad
struct ActivityItem {
    let id: Int
    let icon: String
    let label: String
}

struct ActivityButton: View {
    let icon: String
    let label: String

    var body: some View {
        NavigationLink(destination: ActivityScreen(activity: label, icon: icon)) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                Text(label)
                    .foregroundColor(.white)
                    .font(.system(size: 10))
            }
            .frame(width: 130, height: 20)
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.16, green: 0.58, blue: 0.65), Color(red: 1.0, green: 0.65, blue: 0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
