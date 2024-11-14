

class User: Decodable {
    var name: String = ""
    var score: Int = 0
    
    init() {}
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""
        self.score = json["score"] as? Int ?? 0
    }
    
}
