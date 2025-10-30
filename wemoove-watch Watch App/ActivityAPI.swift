import Foundation

// Struct para representar una actividad (opcional, para tipado fuerte)
struct Activity {
    let activity_type_id: Int
    let user_id: Int
    let start_date: String
    let end_date: String
    let total_duration: String
    let total_distance: String
    let total_calories: String
    let challenge_id: Int
    let challenge_completed: Bool
    let route: String
}

// Función principal para guardar actividad (adaptada del código TypeScript)
func saveActivityUser(
    activity_type_id: Int,
    user_id: Int,
    start_date: String,
    end_date: String,
    total_duration: String,
    total_distance: String,
    total_calories: String,
    challenge_id: Int,
    challenge_completed: Bool,
    route: String,
    jwt: String,
    baseURL: String = "https://back.wemoove.app"  // Reemplaza con tu URL real
) async throws -> [String: Any] {
    // Construir la URL
    guard let url = URL(string: "\(baseURL)/api/V1/users/activities") else {
        throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
    }
    
    // Construir el payload
    let payload: [String: Any] = [
        "activity_type_id": activity_type_id,
        "user_id": user_id,
        "start_date": start_date,
        "end_date": end_date,
        "total_duration": total_duration,
        "total_distance": total_distance,
        "total_calories": total_calories,
        "challenge_id": challenge_id,
        "challenge_completed": challenge_completed,
        "route": route
    ]
    
    // Serializar a JSON
    let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
    
    // Crear la petición
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
    request.httpBody = jsonData
    
    // Ejecutar la petición
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // Verificar respuesta
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
    }
    
    // Parsear respuesta JSON
    guard let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        throw NSError(domain: "ParseError", code: 0, userInfo: nil)
    }
    
    return jsonResponse
}

// Función helper para usar con struct Activity (opcional)
func saveActivityUser(from activity: Activity, jwt: String, baseURL: String = "https://tu-api-url.com") async throws -> [String: Any] {
    return try await saveActivityUser(
        activity_type_id: activity.activity_type_id,
        user_id: activity.user_id,
        start_date: activity.start_date,
        end_date: activity.end_date,
        total_duration: activity.total_duration,
        total_distance: activity.total_distance,
        total_calories: activity.total_calories,
        challenge_id: activity.challenge_id,
        challenge_completed: activity.challenge_completed,
        route: activity.route,
        jwt: jwt,
        baseURL: baseURL
    )
}