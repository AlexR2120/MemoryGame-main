import Foundation

class Usuario: Codable{
    var name: String
    var score: Int
    
    init(nombre: String, puntuacion: Int) {
        self.name = nombre
        self.score = puntuacion
    }
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""
        self.score = json["score"] as? Int ?? 0
    }
}
