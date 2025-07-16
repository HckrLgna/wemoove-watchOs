import SwiftUI
 
struct ActivityScreen: View {
    let activity: String
        let icon: String

    @State private var timer: Timer?
    @State private var elapsed: TimeInterval = 0
    @State private var running = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.accentColor)
                Text(activity)
                    .font(.headline)
            }
            Text(timeString)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)

            HStack(spacing: 18) {
                Button(action: start) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                }
                Button(action: pause) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.yellow)
                }
                Button(action: reset) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(activity)
        .onDisappear { timer?.invalidate() }
    }

    var timeString: String {
        let minutes = Int(elapsed) / 60
        let seconds = Int(elapsed) % 60
        let centiseconds = Int((elapsed - floor(elapsed)) * 100)
        return String(format: "%02d:%02d:%02d", minutes, seconds, centiseconds)
    }

    func start() {
        if running { return }
        running = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            elapsed += 0.01
        }
    }

    func pause() {
        running = false
        timer?.invalidate()
    }

    func reset() {
        running = false
        timer?.invalidate()
        elapsed = 0
    }
}