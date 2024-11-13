import UIKit

class OnlineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var onlineTableView: UITableView!
    
    var onlineScores: [Usuario] = []  // Array para almacenar las puntuaciones que se cargarán del servidor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onlineTableView.dataSource = self
        onlineTableView.delegate = self
        loadOnlineScores()  // Llamar para cargar las puntuaciones online
    }

    // Función para cargar puntuaciones desde el servidor
    func loadOnlineScores() {
        guard let url = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?select=*") else {
            print("URL no válida")
            return
        }
        
        // Configuración de la solicitud GET con las cabeceras de autenticación
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiI...", forHTTPHeaderField: "Authorization")

        // Realizamos la solicitud HTTP
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error al obtener las puntuaciones:", error ?? "Error desconocido")
                return
            }
            
            // Parseamos el JSON recibido
            do {
                // Decodificamos el JSON a un diccionario
                let decodedResponse = try JSONDecoder().decode([String: [Usuario]].self, from: data)
                // Accedemos a la clave 'data' que contiene el array de puntuaciones
                if let scores = decodedResponse["data"] {
                    DispatchQueue.main.async {
                        // Actualizamos la lista y recargamos la tabla
                        self.onlineScores = scores
                        self.onlineTableView.reloadData()
                        print("Puntuaciones cargadas: \(self.onlineScores.count)")  // Verifica que los datos se cargan correctamente
                    }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineScoreCell", for: indexPath)
        let usuario = onlineScores[indexPath.row]
        cell.textLabel?.text = "\(usuario.name): \(usuario.score) puntos"
        return cell
    }
}
