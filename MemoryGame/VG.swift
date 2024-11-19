import UIKit

let imageList = [
    UIImage(named: "luffy"),
    UIImage(named: "zoro"),
    UIImage(named: "sanji"),
    UIImage(named: "brook"),
    UIImage(named: "shanks"),
    UIImage(named: "ace")
]

var selectedImageIndexes = [Int]()
var currentPlayer = Player()
var currentScore = 0
var users = [Player]()

let urlAPI = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?select=*")
let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
