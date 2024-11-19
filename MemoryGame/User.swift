import Foundation

class Player: Decodable {
    var name: String
    var score: Int

    init(name: String = "", score: Int = 0) {
        self.name = name
        self.score = score
    }

    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""
        self.score = json["score"] as? Int ?? 0
    }
}
