import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var onlineScoresButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentPlayerScore()
    }

    func displayCurrentPlayerScore() {
        playerNameLabel.text = "Jugador: \(currentPlayer.name)"
        scoreLabel.text = "Puntuación: \(currentScore)"
        saveCurrentScore()
    }

    func saveCurrentScore() {
        currentPlayer.score = currentScore
        postScoreToAPI(player: currentPlayer)
    }

    func postScoreToAPI(player: Player) {
        guard let url = urlAPI else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apikey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let scoreData: [String: Any] = [
            "name": player.name,
            "score": player.score
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: scoreData, options: .prettyPrinted)
        } catch {
            print("Error serializando datos de puntuación: \(error)")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error enviando puntuación: \(error)")
                return
            }
            print("Puntuación enviada correctamente.")
        }.resume()
    }

    @IBAction func replayButtonPressed(_ sender: UIButton) {
        currentScore = 0
        selectedImageIndexes.removeAll()
        dismiss(animated: true)
    }

    @IBAction func viewOnlineScoresButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "OnlineScores", sender: nil)
    }
}
