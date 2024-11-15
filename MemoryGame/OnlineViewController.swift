import UIKit

class OnlineViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tablaOnline: UITableView!
    var puntuacionesOnline = [(name: String, score: Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaOnline.dataSource = self
        peticionGET()
    }
    
    func peticionGET() {
        guard let url = urlAPI else { return }
        var solicitudGET = URLRequest(url: url)
        solicitudGET.httpMethod = "GET"
        solicitudGET.addValue(apikey, forHTTPHeaderField: "apikey")
        
        URLSession.shared.dataTask(with: solicitudGET) { data, response, error in
            guard let data = data else { return }
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    self.puntuacionesOnline = jsonArray.compactMap { dict in
                        if let name = dict["name"] as? String, let score = dict["score"] as? Int {
                            return (name, score)
                        }
                        return nil
                    }
                    DispatchQueue.main.async {
                        self.tablaOnline.reloadData()
                    }
                }
            } catch {
                print("Error al procesar JSON: \(error)")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return puntuacionesOnline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaOnline", for: indexPath)
        let puntuacion = puntuacionesOnline[indexPath.row]
        celda.textLabel?.text = "\(puntuacion.name): \(puntuacion.score)"
        return celda
    }
}
