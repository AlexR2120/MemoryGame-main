import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ShowOnlineScores: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    var currentUsuario: Usuario?
    var scoreHistory: [Usuario] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        
        // Cargar el historial de puntuaciones
        loadScores()
        
        // Si hay una puntuación actual, agregarla al historial
        if let usuario = currentUsuario {
            scoreHistory.insert(usuario, at: 0) // Agregar la puntuación actual al principio del historial
        }
        
        // Guardar el historial actualizado
        saveScores()
        
        if let usuario = currentUsuario {
            currentScoreLabel.text = "Puntuación Actual: \(usuario.puntuacion)"
        }
        
        // Recargar la tabla para mostrar las puntuaciones
        tableView.reloadData()
    }
    
    // Cargar las puntuaciones guardadas desde UserDefaults
    func loadScores() {
        if let savedHistory = UserDefaults.standard.array(forKey: "scoreHistory") as? [[String: Any]] {
            for entry in savedHistory {
                if let name = entry["name"] as? String, let score = entry["score"] as? Int {
                    let usuario = Usuario(nombre: name, puntuacion: score)
                    scoreHistory.append(usuario)
                }
            }
        }
    }

    // Guardar las puntuaciones en UserDefaults
    func saveScores() {
        var savedHistory: [[String: Any]] = []
        for usuario in scoreHistory {
            savedHistory.append(["name": usuario.nombre, "score": usuario.puntuacion])
        }
        UserDefaults.standard.set(savedHistory, forKey: "scoreHistory")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        let usuario = scoreHistory[indexPath.row]
        cell.textLabel?.text = "\(usuario.nombre): \(usuario.puntuacion) puntos"
        
        return cell
    }
    
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "MainScreen", sender: nil)
    }
    
    @IBAction func ShowOnlineScores(_ sender: Any) {
        performSegue(withIdentifier: "ShowOnlineScores", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOnlineScores"{
            
        }
    }
}
