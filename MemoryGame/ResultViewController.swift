import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentScore: Int = 0
    var scores: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadScores()  // Cargar puntuaciones anteriores
        saveCurrentScore()  // Guardar la puntuación actual
        tableView.reloadData()  // Actualizar la tabla para mostrar los datos
    }
    
    func loadScores() {
        // Cargar puntuaciones anteriores desde UserDefaults
        scores = UserDefaults.standard.array(forKey: "scores") as? [Int] ?? []
    }
    
    func saveCurrentScore() {
        // Añadir la puntuación actual al inicio de la lista
        scores.insert(currentScore, at: 0)
        
        // Guardar el array actualizado en UserDefaults
        UserDefaults.standard.set(scores, forKey: "scores")
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        // Muestra cada puntuación en la tabla
        cell.textLabel?.text = "Puntuación: \(scores[indexPath.row])"
        return cell
    }

    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "MainScreen", sender: nil)
    }
}
