import Foundation
import UIKit


var actualPuntuation = 0
var puntuations = [User]()
var user = User()
var users: [User] = []


var urlAPI = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?select=*")

let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
