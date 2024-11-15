import Foundation

class Usuario: Codable {
    var nombre: String
    var puntuacion: Int

    init(nombre: String, puntuacion: Int) {
        self.nombre = nombre
        self.puntuacion = puntuacion
    }

    // Constructor para inicializar desde un JSON
    init?(json: [String: Any]) {
        guard let nombre = json["nombre"] as? String,
              let puntuacion = json["puntuacion"] as? Int else {
            return nil
        }
        self.nombre = nombre
        self.puntuacion = puntuacion
    }
}
