import UIKit

class OnlineViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!

    var onlineScores: [Usuario] = []  // Array para almacenar las puntuaciones que se cargarán del servidor

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self  // Configuración del data source
        loadOnlineScores()           // Cargar las puntuaciones online
    }

    // Función para cargar puntuaciones desde el servidor
    func loadOnlineScores() {
        guard let url = URL(string: "https://tu_api.com/obtener_puntuaciones") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error al obtener las puntuaciones:", error ?? "Error desconocido")
                return
            }
            
            // Parsear el JSON recibido
            do {
                self.onlineScores = try JSONDecoder().decode([Usuario].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error al parsear JSON:", error)
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineScores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        let usuario = onlineScores[indexPath.row]
        cell.textLabel?.text = "\(usuario.nombre): \(usuario.puntuacion) puntos"
        return cell
    }

    // Acción para cerrar la pantalla
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
