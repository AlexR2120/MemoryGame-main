import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tablaPuntuacion: UITableView!
    @IBOutlet weak var resultadoActual: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPuntuacion.dataSource = self
        resultadoActual.text = "Resultado actual: \(puntuacionActual)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return puntuaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        let puntuacion = puntuaciones[indexPath.row]
        celda.textLabel?.text = "\(puntuacion.name): \(puntuacion.score)"
        return celda
    }
    
    @IBAction func subirPuntuacion(_ sender: UIButton) {
        peticionPOST()
    }
    
    @IBAction func verOnline(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowOnlineScores", sender: nil)
    }
    
    func peticionPOST() {
        guard let url = urlAPI else { return }
        var solicitudPOST = URLRequest(url: url)
        solicitudPOST.httpMethod = "POST"
        solicitudPOST.addValue(apikey, forHTTPHeaderField: "apikey")
        solicitudPOST.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parametros = "name=\(String(describing: usuario?.nombre))&score=\(puntuacionActual)"
        solicitudPOST.httpBody = parametros.data(using: .utf8)
        
        URLSession.shared.dataTask(with: solicitudPOST) { data, response, error in
            if error == nil {
                print("Puntuación subida.")
            } else {
                print("Error al subir puntuación.")
            }
        }.resume()
    }
}
