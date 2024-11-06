import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var currentScore: Int = 0
    var playerName: String = ""
    var scoreHistory: [(name: String, score: Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Insertar la puntuación actual al inicio del historial
        scoreHistory.insert((name: playerName, score: currentScore), at: 0)
        
        tableView.dataSource = self
        tableView.reloadData()
    }

    // Número de secciones: una para la puntuación actual y otra para el historial
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Número de filas por sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // Solo una fila para la puntuación actual
        } else {
            return scoreHistory.count - 1 // Historial de partidas anteriores
        }
    }

    // Celdas para la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        if indexPath.section == 0 {
            // Puntuación actual
            let currentScoreEntry = scoreHistory[0]
            cell.textLabel?.text = "Puntuación actual - \(currentScoreEntry.name): \(currentScoreEntry.score) puntos"
        } else {
            // Historial de puntuaciones
            let pastScoreEntry = scoreHistory[indexPath.row + 1] // +1 para omitir la puntuación actual
            cell.textLabel?.text = "\(pastScoreEntry.name): \(pastScoreEntry.score) puntos"
        }
        return cell
    }
    
    // Títulos para las secciones
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Puntuación Actual"
        } else {
            return "Historial de Partidas"
        }
    }
    
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "MainScreen", sender: nil)
    }
}
