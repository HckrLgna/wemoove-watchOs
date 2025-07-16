//
//  ContentView.swift
//  wemoove-watch Watch App
//
//  Created by mac on 16/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ActivityButton(icon: "figure.walk", label: "Walk")
                ActivityButton(icon: "figure.run", label: "Run")
                ActivityButton(icon: "bicycle", label: "Bike")
                ActivityButton(icon: "figure.pool.swim", label: "Swim")
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.teal, .orange]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
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
                    .font(.system(size: 13))
            }
            .frame(width: 130, height: 30)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.teal, .orange]),
                    startPoint: .leading,
                    endPoint: .trailing
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
