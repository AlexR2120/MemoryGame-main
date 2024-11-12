import Foundation

class Usuario: Decodable{
    var nombre: String
    var puntuacion: Int
    
    init(nombre: String, puntuacion: Int) {
        self.nombre = nombre
        self.puntuacion = puntuacion
    }
}
