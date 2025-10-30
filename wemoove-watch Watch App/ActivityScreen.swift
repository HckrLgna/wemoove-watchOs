import SwiftUI
 
struct ActivityScreen: View {
    let activity: String
    let icon: String
    let userId: Int  // Añadido: pasa desde ContentView
    let jwt: String  // Añadido: pasa desde ContentView

    @State private var timer: Timer?
    @State private var elapsed: TimeInterval = 0
    @State private var running = false
    @State private var startTime: Date?  // Añadido: para calcular start_date
    
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
        startTime = Date()  // Añadido: registra inicio
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
        
        // Guardar actividad antes de resetear
        Task {
            do {
                let response = try await saveActivityUser(
                    activity_type_id: activityTypeId(for: activity),  // Función helper para mapear "Run" a 1, etc.
                    user_id: userId,
                    start_date: startTime?.ISO8601Format() ?? Date().ISO8601Format(),
                    end_date: Date().ISO8601Format(),
                    total_duration: timeString,
                    total_distance: "0",  // Calcula si tienes datos de sensor
                    total_calories: "0",  // Calcula basado en duración/intensidad
                    challenge_id: 0,
                    challenge_completed: false,
                    route: "{}",  // GPX vacío por defecto
                    jwt: jwt
                )
                print("Actividad guardada:", response)
            } catch {
                print("Error guardando:", error)
            }
        }
        
        elapsed = 0
        startTime = nil
    }

    // Helper para mapear nombre de actividad a ID
    private func activityTypeId(for activity: String) -> Int {
        switch activity {
        case "Run": return 1
        case "Cycle": return 2
        // Añade más casos
        default: return 0
        }
    }
}