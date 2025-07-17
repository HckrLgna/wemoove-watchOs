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
            Spacer(minLength: 30)
            VStack(spacing: 2) {
                ActivityButton(icon: "figure.walk", label: "Walk")
                ActivityButton(icon: "figure.run", label: "Run")
                ActivityButton(icon: "bicycle", label: "Bike")
                ActivityButton(icon: "figure.pool.swim", label: "Swim")
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            //.padding(.bottom, 10)
            //.padding(.vertical,4)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 102/255, green: 0/255, blue: 255/255),
                        Color(red: 102/255, green: 0/255, blue: 255/255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
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
