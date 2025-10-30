import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    func applicationDidFinishLaunching() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    // Recibe mensajes desde la app iOS
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let userId = message["userId"] as? String {
            UserDefaults.standard.set(userId, forKey: "userId")
            print("UserId recibido en watch: \(userId)")
        }
        if let jwt = message["jwt"] as? String {
            UserDefaults.standard.set(jwt, forKey: "jwt")
            print("JWT recibido en watch: \(jwt)")
        }
    }

    // Método corregido: firma exacta del protocolo
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Error activando WCSession en watch: \(error.localizedDescription)")
        } else {
            print("WCSession activado en watch")
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        // Maneja inactividad
    }

    func sessionDidDeactivate(_ session: WCSession) {
        // Maneja desactivación
    }
}