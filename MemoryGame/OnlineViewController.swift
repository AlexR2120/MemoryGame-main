import UIKit

class OnlineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var onlineScoresTable: UITableView!
    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        onlineScoresTable.delegate = self
        onlineScoresTable.dataSource = self
        fetchOnlineScores()
    }

    func fetchOnlineScores() {
        var request = URLRequest(url: urlAPI!)
        request.httpMethod = "GET"
        // Agregar la clave de la API en las cabeceras
            request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "apikey")
            
            // Agregar el token de autorización si es necesario
            request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("Respuesta JSON recibida: \(json)")  // Imprime la respuesta JSON completa

                    // Verificar si la respuesta es un arreglo de diccionarios
                    if let jsonArray = json as? [[String: Any]] {
                        users.removeAll()
                        for item in jsonArray {
                            users.append(Player(json: item))
                        }
                        DispatchQueue.main.async {
                            self.onlineScoresTable.reloadData()
                        }
                    }
                    // Caso en que la respuesta es un diccionario que contiene un arreglo de jugadores
                    else if let jsonDict = json as? [String: Any], let players = jsonDict["players"] as? [[String: Any]] {
                        users.removeAll()
                        for item in players {
                            users.append(Player(json: item))
                        }
                        DispatchQueue.main.async {
                            self.onlineScoresTable.reloadData()
                        }
                    } else {
                        print("La respuesta no es el formato esperado (arreglo de diccionarios o diccionario con jugadores).")
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }.resume()
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "onlineCell", for: indexPath)
        cell.textLabel?.text = "\(users[indexPath.row].name): \(users[indexPath.row].score)"
        return cell
    }
}
