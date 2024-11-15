import Foundation
import UIKit

// Lista de imágenes para el juego
let listaImagenes = [
    UIImage(named: "luffy"),
    UIImage(named: "zoro"),
    UIImage(named: "sanji"),
    UIImage(named: "brook"),
    UIImage(named: "ace"),
    UIImage(named: "shanks")
]

var imagenesSeleccionadas = [UIImage]()
var puntuacionActual = 0
var puntuaciones: [(name: String, score: Int)] = []
var usuario = Usuario(json: <#[String : Any]#>)
var urlAPI = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?select=*")
let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
