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
        request.addValue(apikey, forHTTPHeaderField: "apikey")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    users.removeAll()
                    for item in json as! [[String: Any]] {
                        users.append(Player(json: item))
                    }
                    DispatchQueue.main.async {
                        self.onlineScoresTable.reloadData()
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
